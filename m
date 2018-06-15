Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142D5C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46FC208EA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFwNB/mc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C46FC208EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966449AbeFOTvr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 15:51:47 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42977 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966120AbeFOTvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 15:51:45 -0400
Received: by mail-lf0-f66.google.com with SMTP id v135-v6so16241419lfa.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 12:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XxeI+Db9Z2DvdlS4Y03LmdB0jkHe/57Fo9DEqP7kd3U=;
        b=qFwNB/mchYK6aJGr/6EPM78A+3qxhc2XaQaAxcElL4ng9tEvmyyW3AJQKcA985ArOc
         XEits1msUnLkU33+PUgX/Aw9wi8lvwbxlXvSWBTxF87u0VCdzrxnj3yL1lAfxN6npAwV
         TKNu41GzuHHJlhcOtr1ICBlaLTSA0Tc80It+w1WrBPo+u/JgKaezUPZr/W2gfqUgfsHF
         OBlFX+CduDX7is0kl444ugR/vqNCjOVWRjYUdpfRzAyRs0wgNGAhGVsQNiYZbXUm3Skp
         1v6Ol/BUlvZAiydbYKnkt3ckkhLXm6r6SQGhMXn1jmRrAxf5aCrJ6ojcVbCf+lbCCvhN
         3xqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XxeI+Db9Z2DvdlS4Y03LmdB0jkHe/57Fo9DEqP7kd3U=;
        b=nsbI1YKekT64+HbGuKSw9EAoeC7vlH9F7c5D4xgCixWPEiLLtTZ0EcOC6SnsKbauzV
         wfdk15AKPVQ0q4KNMsuLAixUMs62FdReCo5X0LyfE4PDnyETk85bhSoCWc0ph01Gbr7g
         0ObcQvRg4hDU1tdtV4lx7d38LaBsp3kTZv8+nGdwNqB2BwM9c0g7do8UBoauc3OUCCli
         zw+8DXh4/7jjdqaDVcYEhEpm/u1yLduar8b8u+zA1xcNe6Gr9+XB7bfst07IudrinwCY
         B9GooXPKx9QIhwqMh+G16JsxDfNw2oewNRwPOU7S2lpr9jU44WyL8Bwq5vV/bTllG4Vg
         5Zkw==
X-Gm-Message-State: APt69E1gitgFczRcsfPE3TID7ivb2/6/cdXDx3cWZkoEEtDUsReqdDmv
        IuQCeuQBf+S96Kwy+uU7arc=
X-Google-Smtp-Source: ADUXVKLN/ybZ+pcSgkN1Cjsj4NXOVkRwWVLMP6ZGDBY9XnZkYMQfUyNLuyBjUNRB3faHmHLhHi3QGg==
X-Received: by 2002:a19:8e4e:: with SMTP id q75-v6mr2067375lfd.95.1529092304246;
        Fri, 15 Jun 2018 12:51:44 -0700 (PDT)
Received: from mobilestation ([5.166.218.73])
        by smtp.gmail.com with ESMTPSA id p28-v6sm1631581lfh.24.2018.06.15.12.51.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 12:51:43 -0700 (PDT)
Date:   Fri, 15 Jun 2018 22:51:52 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 8/8] NTB: ntb_test: Fix bug when counting remote files
Message-ID: <20180615195152.GA25605@mobilestation>
References: <20180609000819.13883-1-logang@deltatee.com>
 <20180609000819.13883-10-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609000819.13883-10-logang@deltatee.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 06:08:19PM -0600, Logan Gunthorpe <logang@deltatee.com> wrote:
> When remote files are counted in get_files_count, without using SSH,
> the code returns 0 because there is a colon prepended to $LOC. $VPATH
> should have been used instead of $LOC.
> 

Good catch. Thanks for the patch. I discovered this problem myself a few days
before you sent this patchset. So was going to submit the fix, but you were
faster.

I also tested this script in the looped-back setup. It is the case when two
NTB-device ports are available at the same RootComplex. So the NTB can be
configured from the single executional context. In this case the REMOTE_HOST is left
empty, so the colon is left prepended to the corresponding paths and causes multiple
errors including the one fixed by this patch. In order to fix it, we need to discard
the colon for remote-less case, for instance, by the next patch:

@@ -482,7 +495,11 @@ function perf_test()
 function ntb_tool_tests()
 {
 	LOCAL_TOOL="$DEBUGFS/ntb_tool/$LOCAL_DEV"
-	REMOTE_TOOL="$REMOTE_HOST:$DEBUGFS/ntb_tool/$REMOTE_DEV"
+	if [[ "${REMOTE_HOST}" != "" ]]; then
+		REMOTE_TOOL="$REMOTE_HOST:$DEBUGFS/ntb_tool/$REMOTE_DEV"
+	else
+		REMOTE_TOOL="$DEBUGFS/ntb_tool/$REMOTE_DEV"
+	fi
 
 	echo "Starting ntb_tool tests..."
 
And so on for REMOTE_PP and REMOTE_PERF. It is necessary for NTB devices, which ports
are looped-back to the same Root-Port. Would you be amenable if you resent this patch
together with the fix I suggested?

Regards,
-Sergey

> Fixes: 06bd0407d06c ("NTB: ntb_test: Update ntb_tool Scratchpad tests")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  tools/testing/selftests/ntb/ntb_test.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ntb/ntb_test.sh b/tools/testing/selftests/ntb/ntb_test.sh
> index 08cbfbbc7029..17ca36403d04 100755
> --- a/tools/testing/selftests/ntb/ntb_test.sh
> +++ b/tools/testing/selftests/ntb/ntb_test.sh
> @@ -250,7 +250,7 @@ function get_files_count()
>  	split_remote $LOC
>  
>  	if [[ "$REMOTE" == "" ]]; then
> -		echo $(ls -1 "$LOC"/${NAME}* 2>/dev/null | wc -l)
> +		echo $(ls -1 "$VPATH"/${NAME}* 2>/dev/null | wc -l)
>  	else
>  		echo $(ssh "$REMOTE" "ls -1 \"$VPATH\"/${NAME}* | \
>  		       wc -l" 2> /dev/null)
> -- 
> 2.11.0
> 
