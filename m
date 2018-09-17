Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5281ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EED5214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EED5214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeIQPKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 11:10:42 -0400
Received: from mail.windriver.com ([147.11.1.11]:44933 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeIQPKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 11:10:42 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w8H9hoAw004511
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 17 Sep 2018 02:43:51 -0700 (PDT)
Received: from [128.224.162.216] (128.224.162.216) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 17 Sep
 2018 02:43:50 -0700
Subject: Re: [PATCH] scripts/gcc-goto.sh: Show stdout and stderr for potential
 errors
To:     <tglx@linutronix.de>, <kstewart@linuxfoundation.org>,
        <pombredanne@nexb.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
References: <1533803685-42422-1-git-send-email-zhe.he@windriver.com>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <70e45fbe-b447-ee69-c870-c45f37a8f2c3@windriver.com>
Date:   Mon, 17 Sep 2018 17:43:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533803685-42422-1-git-send-email-zhe.he@windriver.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [128.224.162.216]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

May I have your input?

Thanks,
Zhe

On 2018年08月09日 16:34, zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
>
> The check may fail not only because ${CC} does not support the asm
> feature, but also due to potential defects of ${CC} itself like what
> we experienced below or even it's missing.
>
> Assembler messages:
> Fatal error: The input and output files must be distinct
> (introduced by binutils-2.31 "Stop the assembler from overwriting its
> output file.")
>
> This patch enables stdout and stderr to give user direct error
> information for those cases, while not polluting the output for normal
> cases.
>
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
>  scripts/gcc-goto.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/gcc-goto.sh b/scripts/gcc-goto.sh
> index 083c526..bd7fc8eb 100755
> --- a/scripts/gcc-goto.sh
> +++ b/scripts/gcc-goto.sh
> @@ -3,7 +3,7 @@
>  # Test for gcc 'asm goto' support
>  # Copyright (C) 2010, Jason Baron <jbaron@redhat.com>
>  
> -cat << "END" | $@ -x c - -c -o /dev/null >/dev/null 2>&1 && echo "y"
> +cat << "END" | $@ -x c - -c -o /dev/null && echo "y"
>  int main(void)
>  {
>  #if defined(__arm__) || defined(__aarch64__)

