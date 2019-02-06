Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAE4C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D00B218D9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z6Q+q2TG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfBFWsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 17:48:33 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37934 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfBFWsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 17:48:33 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x16Mi9CI051603;
        Wed, 6 Feb 2019 22:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=6oeYaHpL97KRHrw/SUIRK15B/EH29MQg6WqKzUHlWuw=;
 b=Z6Q+q2TG9uLsn4fm3bdpD2BJ0wxKL25DCd6F9R8YnZfsv9r8XvUHjOsaDu/de1jJ/810
 xUDlzTfXc2sOMfXb68i5VMjIVzd+lbX0QXDq/sHdyuQ2neP6nWc1EaYrK+O5mCgse4wF
 r20FKNGRqQgc60l2mAaIsg6dDCVtGI2ruR5YuHoLyaD1wI8Ooh3iSf+VTPVU4gseVzU8
 R+3Yp9OYFS/ma+blxT6y6mBE2Ntqh6GK8+fmOCIzeW5nUoRax3Z50NfssDoIWZ54zfK8
 8S+2IvWi2XwCxs/5vl7Tps9ICRRbUmOcnEe4zZZYUYssdWfeFSlzevC7ejapvmqpIsZj pQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2qd9arkwbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Feb 2019 22:48:19 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x16MmCFC013237
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Feb 2019 22:48:12 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x16MmAMu019058;
        Wed, 6 Feb 2019 22:48:11 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Feb 2019 14:48:10 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.2\))
Subject: Re: [PATCH v2 0/3] slub: Do trivial comments fixes
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20190205040521.GB30744@eros.localdomain>
Date:   Wed, 6 Feb 2019 15:48:09 -0700
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christopher Lameter <cl@linux.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <70B0A145-EAED-40A1-9C3C-2792EC3A5C24@oracle.com>
References: <20190204005713.9463-1-tobin@kernel.org>
 <20190204150410.f6975adaddfeb638c9f21580@linux-foundation.org>
 <20190205040521.GB30744@eros.localdomain>
To:     "Tobin C. Harding" <me@tobin.cc>
X-Mailer: Apple Mail (2.3445.104.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9159 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=632 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902060170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


If you need it:

Reviewed-by: William Kucharski <william.kucharski@oracle.com>
