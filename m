Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161299AbeEXVYE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 17:24:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54086 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033204AbeEXVYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 17:24:03 -0400
Date: Thu, 24 May 2018 17:23:55 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc: joe.jin@oracle.com
Subject: [GIT PULL] (swiotlb) stable/for-linus-4.17
Message-ID: <20180524212355.GB5947@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8903 signatures=668700
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=885
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805240241
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Linus,

Please git pull the following branch in your tree:

git pull git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git stable/for-linus-4.17

There is one single fix in there - that is under Xen the DMA32 heap
(in the hypervisor) would end up looking like swiss cheese. The reason
being that for every coherent DMA allocation we didn't do the proper
hypercall to tell Xen to return the page back to the DMA32 heap.
End result was (eventually) no DMA32 space if say you say continously
unloaded and loaded modules.

Thank you.

 drivers/xen/swiotlb-xen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Joe Jin (1):
      xen-swiotlb: fix the check condition for xen_swiotlb_free_coherent


--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbBy1rAAoJEFKlDoTx2wm/jnoP/jvxyAetAQzmicIdeHL0NlCa
qEWM8CU8NmyCXjncJGNJ93ZWt1yZuVXayUwwwYDCCZ4UJ9jN6bGCRpaOiebSfS7A
MDzjvbAtMOQh6eJQRM4ZMm1Pst7y91+3jdSwKr/+ULYrdODeGfPrNnYzu8S2S8k8
lOgC85cdl7TKwc8aWZttJE85s8ozBgtjsDayvDOogmgPnUdAwPeamp3G2jnZSCVC
EnB0/AIpbM59nZYZq6WUwOhW+j9g+uyiBVug+/AxMS+7S30KB/ES1k1xSsNM/Eop
korh7VYAJe7RBHjKkHs7qwuVK/M3PaiDEw9TZ4MCkG+KlF6GCOVsSZ4OuSSvhIFc
8YicBqr6GGbImw4g5RX4VK6TkPNm5YUxSs5rDuVldR2/bBX3GoOCqAyaBUzoafQu
5ZAoMGoAILEdmG/yUtT3Nm+WZGUNV5VG1D2SIJRYf1K5hBmCBwN4/HRrl1mLUugh
5aw1KpWke7k2YhymFVgup5ejjeoeLEkUQDHKMSYYZ8faTakm+2g62L5i+30FvBpx
gwk1EVizvQYjvu7Ywg2KYcaNK1FCph4byIiuNPBj5KRFuS6PDdZGnFcUvejdOwAA
T7EKkKPVLoQ08VLd1YD9SmU1pLyZ09DcnhLOI9mSzay/X4fLoFtCgW7ZLpj5vQ4F
eKjCD1fAR322wDdA0vsi
=Kiui
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
