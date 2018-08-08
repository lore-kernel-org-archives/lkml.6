Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2C1C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FBA219E6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71FBA219E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeHHR1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:27:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727069AbeHHR1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:27:41 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w78F0KHV154195
        for <linux-kernel@vger.kernel.org>; Wed, 8 Aug 2018 11:07:36 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kr1w2b5xb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 11:07:36 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 8 Aug 2018 16:07:15 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 8 Aug 2018 16:07:12 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w78F7AFg26148874
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Aug 2018 15:07:10 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B4D211C04A;
        Wed,  8 Aug 2018 18:07:17 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D77B11C058;
        Wed,  8 Aug 2018 18:07:16 +0100 (BST)
Received: from [9.145.27.150] (unknown [9.145.27.150])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  8 Aug 2018 18:07:16 +0100 (BST)
Subject: Re: [PATCH v8 00/22] vfio-ap: guest dedicated crypto adapters
To:     Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        Tony Krowiak <akrowiak@linux.ibm.com>
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
From:   Janosch Frank <frankja@linux.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
 lFM6NIuMAY1Y
Date:   Wed, 8 Aug 2018 17:06:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sCi5QhxMEQraj6sayyLdi69pY509KrRXy"
X-TM-AS-GCONF: 00
x-cbid: 18080815-0028-0000-0000-000002E7FBC1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080815-0029-0000-0000-000023A106E5
Message-Id: <5c4c8a0e-85b0-b5de-e9a2-7498c64557bd@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-08_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=906 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808080155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sCi5QhxMEQraj6sayyLdi69pY509KrRXy
Content-Type: multipart/mixed; boundary="jskYqaGEvjEJpS2vJ3CXWzfEholTiTmiN";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
 borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
 bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
 alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
 alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
 jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
 berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
 Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <5c4c8a0e-85b0-b5de-e9a2-7498c64557bd@linux.ibm.com>
Subject: Re: [PATCH v8 00/22] vfio-ap: guest dedicated crypto adapters
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
In-Reply-To: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>

--jskYqaGEvjEJpS2vJ3CXWzfEholTiTmiN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08.08.2018 16:44, Tony Krowiak wrote:
> From: Tony Krowiak <akrowiak@linux.ibm.com>

The patches are also available on git.kernel.org:

https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git/log/?h=3D=
ap


--jskYqaGEvjEJpS2vJ3CXWzfEholTiTmiN--

--sCi5QhxMEQraj6sayyLdi69pY509KrRXy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJbawccAAoJEBcO/8Q8ZEV50uoP/2eTjOm5qMYRorHVKG4G0bC5
1/9PU89CdXCUiARDiGTy1RoLpR1nyVKxzvf8P8ymJ5ilmyB84gDwV7EOsLZEWPHm
zugvAB0S6DkNNCPjnEiWgeDW4zYycjqDdWza+QOG5L+ri1wiqS7bX7LFutp9oUcy
GZ7g7xqGhMt3EvzmNRqQPeKeD3h6K9ZMnZjICtWDn29LgK9yqpvcHE55tWJ/bPQP
pmV5Zg5Gupba2Ba5Nehuo0a/UkGh9sBP/Mh8pDjPf9A78G38cQpqef292pwjVjH8
tHiZ/yLhHqGJzaTU9vfNSxAcfepv0XiIITKiQSkR0e8rSxl38GjYdwABJ20OmT++
KVsHYH7yyt8a9n/p8BeLL1n7bvyPm18rIPpAzAGBlMVltZA81RYgLGzeuBCkk5IL
XeGgUhEF6dEUWuiCplzOJfX77Fls4CEBC3fFr1/8rTNSiXhXuYj2rDeMe3dWWfGb
0t3um30jlV4mdMIGIPXGZt9/b1tRriKrdLrWh2i36f8jvaIN6zVzX+hUzCf8yXxR
G1eLfEABYUGUHoLFWvmzkdW+RAoBxZYPmrn3UkAgAF659NXPmQRPKt6qA/iY42T+
ctDMBoBCs9PDkxJVjIJ4K68ANhzaFoiOPI8SrOwJL6o39xMrJMGU2YdS084ST//w
AhpnhIxbS1pIr67v3DPk
=OTg1
-----END PGP SIGNATURE-----

--sCi5QhxMEQraj6sayyLdi69pY509KrRXy--

