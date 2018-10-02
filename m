Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFDDC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09BD7206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09BD7206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbeJBRsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 13:48:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:64730 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727281AbeJBRsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 13:48:11 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2018 04:05:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,331,1534834800"; 
   d="scan'208";a="85051782"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Oct 2018 04:05:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 82A3C1F5; Tue,  2 Oct 2018 14:05:24 +0300 (EEST)
Date:   Tue, 2 Oct 2018 14:05:24 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCHv3 5/6] tools/gup_benchmark: Add parameter for hugetlb
Message-ID: <20181002110524.ckgrlmx5k54rvawt@black.fi.intel.com>
References: <20180921223956.3485-1-keith.busch@intel.com>
 <20180921223956.3485-6-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921223956.3485-6-keith.busch@intel.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 10:39:55PM +0000, Keith Busch wrote:

-ENOMSG

> Cc: Kirill Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  tools/testing/selftests/vm/gup_benchmark.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vm/gup_benchmark.c b/tools/testing/selftests/vm/gup_benchmark.c
> index f2c99e2436f8..5d96e2b3d2f1 100644
> --- a/tools/testing/selftests/vm/gup_benchmark.c
> +++ b/tools/testing/selftests/vm/gup_benchmark.c
> @@ -38,7 +38,7 @@ int main(int argc, char **argv)
>  	char *file = NULL;
>  	char *p;
>  
> -	while ((opt = getopt(argc, argv, "m:r:n:f:tTLU")) != -1) {
> +	while ((opt = getopt(argc, argv, "m:r:n:f:tTLUH")) != -1) {
>  		switch (opt) {
>  		case 'm':
>  			size = atoi(optarg) * MB;
> @@ -64,6 +64,9 @@ int main(int argc, char **argv)
>  		case 'w':
>  			write = 1;
>  			break;
> +		case 'H':
> +			flags |= MAP_HUGETLB;
> +			break;
>  		case 'f':
>  			file = optarg;
>  			flags &= ~(MAP_PRIVATE | MAP_ANONYMOUS);
> -- 
> 2.14.4
> 

-- 
 Kirill A. Shutemov
