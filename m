Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25FBC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 07:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8128720659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 07:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="n7+Hxdpr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfANHVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 02:21:12 -0500
Received: from esa4.dell-outbound.iphmx.com ([68.232.149.214]:4714 "EHLO
        esa4.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726067AbfANHVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 02:21:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1547450471; x=1578986471;
  h=from:subject:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=vA4wURFwSA2pl4yXFqldiufB3rYm4E7Kim5VtimXgIw=;
  b=n7+HxdprirkTYx0GrYVvsvEN09xP6914ASSP4QBRqhIbaiA3erOEEyXd
   o62ed2VIQd2wbLLjHXD95S+fgmnKLYObHc+Iu2xFxN5Pk2a1Mdpwh3HQ6
   nlUP5Yan+UnGBdj0InxvACoxBWJolb6vKm/NO7ZbRqnGgGbNZCVNjO4Yp
   g=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EhAQCdNzxchiWd50NkHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBZYJqgQInhAGIeYsNgWAtg1qVYTwLAQEfD4Q0CgKCMiI4EgEDAQECAQE?=
 =?us-ascii?q?CAQECEAEBARMLCCkjDII6KQEQBE07MAEBAQEBAQEBAQEBAQEBARoCDWQBAQE?=
 =?us-ascii?q?DEhEVJxoQCxgCAhgOAgJXBgEKAgYCAQEegwABggEPoTY9AoFuiQcBAQFvgS+?=
 =?us-ascii?q?KHAWBC4s0gVg+gTiCa4MFGQKBOoMwglcCkEQ2kQoDBAIChxqKZgYYkX+JdYU?=
 =?us-ascii?q?RhFyDUYMSAgQCBAUCFIFdIIFYcIM8gjWDVIpbOAExAYgRAiQHgiABAQ?=
X-IPAS-Result: =?us-ascii?q?A2EhAQCdNzxchiWd50NkHAEBAQQBAQcEAQGBZYJqgQInh?=
 =?us-ascii?q?AGIeYsNgWAtg1qVYTwLAQEfD4Q0CgKCMiI4EgEDAQECAQECAQECEAEBARMLC?=
 =?us-ascii?q?CkjDII6KQEQBE07MAEBAQEBAQEBAQEBAQEBARoCDWQBAQEDEhEVJxoQCxgCA?=
 =?us-ascii?q?hgOAgJXBgEKAgYCAQEegwABggEPoTY9AoFuiQcBAQFvgS+KHAWBC4s0gVg+g?=
 =?us-ascii?q?TiCa4MFGQKBOoMwglcCkEQ2kQoDBAIChxqKZgYYkX+JdYURhFyDUYMSAgQCB?=
 =?us-ascii?q?AUCFIFdIIFYcIM8gjWDVIpbOAExAYgRAiQHgiABAQ?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa4.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jan 2019 01:21:10 -0600
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0E7Kfss055260;
        Mon, 14 Jan 2019 02:21:10 -0500
Received: from esa6.dell-outbound2.iphmx.com (esa6.dell-outbound2.iphmx.com [68.232.154.99])
        by mx0b-00154901.pphosted.com with ESMTP id 2q0juhgu70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 02:21:10 -0500
From:   "Pandel, Sujith" <Sujith.Pandel@dell.com>
Received: from ausxipps301.us.dell.com ([143.166.148.223])
  by esa6.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Jan 2019 13:21:08 +0600
X-LoopCount0: from 10.94.55.207
X-IronPort-AV: E=Sophos;i="5.56,476,1539666000"; 
   d="scan'208";a="286226852"
Subject: Re: [PATCH] acpi/nfit: Fix command-supported detection
To:     Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        vishal.l.verma@intel.com
References: <154725096972.1367907.12968253382302127133.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID: <29b49260-8b67-ec44-24f6-8fdc32e8f648@dell.com>
Date:   Mon, 14 Jan 2019 12:51:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <154725096972.1367907.12968253382302127133.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-14_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901140064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 12-Jan-19 5:29 AM, Dan Williams wrote:
> The _DSM function number validation only happens to succeed when the
> generic Linux command number translation corresponds with a
> DSM-family-specific function number. This breaks NVDIMM-N
> implementations that correctly implement _LSR, _LSW, and _LSI, but do
> not happen to publish support for DSM function numbers 4, 5, and 6.
>
> Recall that the support for _LS{I,R,W} family of methods results in the
> DIMM being marked as supporting those command numbers at
> acpi_nfit_register_dimms() time. The DSM function mask is only used for
> ND_CMD_CALL support of non-NVDIMM_FAMILY_INTEL devices.
>
> Fixes: 31eca76ba2fc ("nfit, libnvdimm: limited/whitelisted dimm command...")
> Cc: <stable@vger.kernel.org>
> Link: https://github.com/pmem/ndctl/issues/78
> Reported-by: Sujith Pandel <sujith_pandel@dell.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Sujith, this is a larger change than what you originally tested, but it
> should behave the same. I wanted to consolidate all the code that
> handles Linux command number to DIMM _DSM function number translation.
>
> If you have a chance to re-test with this it would be much appreciated.
>
> Thanks for the report!
Re-verified by applying this patch over LTS kernel-4.20.2 with ndctl v62.
namespace creation and modification works fine on Dell NVDIMM-Ns.
Thanks for helping me on this!

Tested-by: Sujith Pandel <sujith_pandel@dell.com>

