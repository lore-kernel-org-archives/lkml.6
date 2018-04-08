Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752467AbeDHCML (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 22:12:11 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:36394 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752068AbeDHCMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 22:12:10 -0400
X-Google-Smtp-Source: AIpwx4+TApsKz1RZNGYY6n57LIPZvdHt2Kt7CMoqgty0yLfEJ/e/ApOuqOo/xApIXL102ESQpFcQSw==
Subject: Re: [PATCH] checkpatch: relax check for revert commit
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, Jia He <jia.he@hxt-semitech.com>
References: <1522679339-19067-1-git-send-email-hejianet@gmail.com>
 <1522679339-19067-2-git-send-email-hejianet@gmail.com>
From: Jia He <hejianet@gmail.com>
Message-ID: <d5f5fbc7-d01f-05e1-f8ac-c1db8ba5fd9e@gmail.com>
Date: Sun, 8 Apr 2018 10:12:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1522679339-19067-2-git-send-email-hejianet@gmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy & Joe

Although it is minor, it is a real bug, I thought.

Is there any comment? Thank you

---

Cheers,

Jia


On 4/2/2018 10:28 PM, Jia He Wrote:
> For revert commit, it might has two double quotation marks in its
> commit log.
>
> Relax the check condition for revert commit to avoid checkpatch
> errors.
>
> Signed-off-by: Jia He <jia.he@hxt-semitech.com>
> ---
>   scripts/checkpatch.pl | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 3d40403..96138d6 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2643,20 +2643,20 @@ sub process {
>   			$long = 1 if ($line =~ /\bcommit\s+[0-9a-f]{41,}/i);
>   			$space = 0 if ($line =~ /\bcommit [0-9a-f]/i);
>   			$case = 0 if ($line =~ /\b[Cc]ommit\s+[0-9a-f]{5,40}[^A-F]/);
> -			if ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)"\)/i) {
> +			if ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("(.*)"\)/i) {
>   				$orig_desc = $1;
>   				$hasparens = 1;
>   			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s*$/i &&
>   				 defined $rawlines[$linenr] &&
> -				 $rawlines[$linenr] =~ /^\s*\("([^"]+)"\)/) {
> +				 $rawlines[$linenr] =~ /^\s*\("(.*)"\)/) {
>   				$orig_desc = $1;
>   				$hasparens = 1;
> -			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("[^"]+$/i &&
> -				 defined $rawlines[$linenr] &&
> -				 $rawlines[$linenr] =~ /^\s*[^"]+"\)/) {
> -				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)$/i;
> +		       } elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\(".*$/i &&
> +				defined $rawlines[$linenr] &&
> +				$rawlines[$linenr] =~ /^\s*.*"\)/) {
> +				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("(.*)$/i;
>   				$orig_desc = $1;
> -				$rawlines[$linenr] =~ /^\s*([^"]+)"\)/;
> +				$rawlines[$linenr] =~ /^\s*(.*)"\)/;
>   				$orig_desc .= " " . $1;
>   				$hasparens = 1;
>   			}
