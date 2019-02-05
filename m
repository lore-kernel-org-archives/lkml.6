Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63071C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF802083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3r4I5WT3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfBEKVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 05:21:48 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:60134 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbfBEKVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 05:21:48 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x15AJJFl195018;
        Tue, 5 Feb 2019 10:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=DPSjdzg4/RyjfHm4HGJ6cP6BJ3fdiCYR8YEkSlF7CWI=;
 b=3r4I5WT3f4oI6GFpBUnZGCphaGH4h6D7jjTbC+GFLFbyrJYuTuaHGbvK1pcnd92rs2Mi
 yWcOiPCGDt3WXM3bOmwyrtMGJmWP5OKN5Af6HZ7MNQXQSGPelJ8ei1M+wvfipz5204Vy
 xYw9kA/X4Y81XDvToF4Q9N4fd2vemECAJitkFDqBjG6MhLyOrcTtZEFVCwdrwV3bLdjq
 Okhd4KZvU4H7gHPNbPmXfYPtX3YBTP8cARgxZ31Z6ug0a7x9DkdH0ZvXGDFdNrLBwr+r
 8JWIKCqsfgDnffTTGXta3qXe4vfz5/OoKvuA34kSdcEta/bAbw+TtFdxyNtJKq+uJsb0 XA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2qd97et3gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Feb 2019 10:21:38 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x15ALUmv013093
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Feb 2019 10:21:31 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x15ALR12025630;
        Tue, 5 Feb 2019 10:21:28 GMT
Received: from kadam (/197.157.0.31)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Feb 2019 10:21:27 +0000
Date:   Tue, 5 Feb 2019 13:21:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org,
        Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>
Cc:     kbuild-all@01.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Input: add Apple SPI keyboard and trackpad driver.
Message-ID: <20190205102110.GG2581@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190204081947.25152-3-ronald@innovation.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9157 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902050083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ronald,

Thank you for the patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/Ronald-Tschal-r/drm-bridge-sil_sii8620-depend-on-INPUT-instead-of-selecting-it/20190205-003319
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next

smatch warnings:
drivers/input/keyboard/applespi.c:1551 applespi_get_saved_bl_level() warn: returning -1 instead of -ENOMEM is sloppy

# https://github.com/0day-ci/linux/commit/cfa9f37054a5b21113aa8b00c455275145114f8e
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout cfa9f37054a5b21113aa8b00c455275145114f8e
vim +1551 drivers/input/keyboard/applespi.c

cfa9f3705 Ronald Tschalär 2019-02-04  1541  
cfa9f3705 Ronald Tschalär 2019-02-04  1542  static int applespi_get_saved_bl_level(void)
cfa9f3705 Ronald Tschalär 2019-02-04  1543  {
cfa9f3705 Ronald Tschalär 2019-02-04  1544  	struct efivar_entry *efivar_entry;
cfa9f3705 Ronald Tschalär 2019-02-04  1545  	u16 efi_data = 0;
cfa9f3705 Ronald Tschalär 2019-02-04  1546  	unsigned long efi_data_len;
cfa9f3705 Ronald Tschalär 2019-02-04  1547  	int sts;
cfa9f3705 Ronald Tschalär 2019-02-04  1548  
cfa9f3705 Ronald Tschalär 2019-02-04  1549  	efivar_entry = kmalloc(sizeof(*efivar_entry), GFP_KERNEL);
cfa9f3705 Ronald Tschalär 2019-02-04  1550  	if (!efivar_entry)
cfa9f3705 Ronald Tschalär 2019-02-04 @1551  		return -1;
cfa9f3705 Ronald Tschalär 2019-02-04  1552  
cfa9f3705 Ronald Tschalär 2019-02-04  1553  	memcpy(efivar_entry->var.VariableName, EFI_BL_LEVEL_NAME,
cfa9f3705 Ronald Tschalär 2019-02-04  1554  	       sizeof(EFI_BL_LEVEL_NAME));
cfa9f3705 Ronald Tschalär 2019-02-04  1555  	efivar_entry->var.VendorGuid = EFI_BL_LEVEL_GUID;
cfa9f3705 Ronald Tschalär 2019-02-04  1556  	efi_data_len = sizeof(efi_data);
cfa9f3705 Ronald Tschalär 2019-02-04  1557  
cfa9f3705 Ronald Tschalär 2019-02-04  1558  	sts = efivar_entry_get(efivar_entry, NULL, &efi_data_len, &efi_data);
cfa9f3705 Ronald Tschalär 2019-02-04  1559  	if (sts && sts != -ENOENT)
cfa9f3705 Ronald Tschalär 2019-02-04  1560  		pr_warn("Error getting backlight level from EFI vars: %d\n",
cfa9f3705 Ronald Tschalär 2019-02-04  1561  			sts);
cfa9f3705 Ronald Tschalär 2019-02-04  1562  
cfa9f3705 Ronald Tschalär 2019-02-04  1563  	kfree(efivar_entry);
cfa9f3705 Ronald Tschalär 2019-02-04  1564  
cfa9f3705 Ronald Tschalär 2019-02-04  1565  	return efi_data;
cfa9f3705 Ronald Tschalär 2019-02-04  1566  }
cfa9f3705 Ronald Tschalär 2019-02-04  1567  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
