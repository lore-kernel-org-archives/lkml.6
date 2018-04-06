Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751623AbeDFSYN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 14:24:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751344AbeDFSYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 14:24:12 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCFDC21720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 6 Apr 2018 14:24:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tim Tianyang Chen <tianyang.chen@oracle.com>
Cc: linux-kernel@vger.kernel.org, dhaval.giani@oracle.com
Subject: Re: [PATCH v3 1/4] Ktest: add email support
Message-ID: <20180406142409.6d98254b@gandalf.local.home>
In-Reply-To: <1522094884-22718-2-git-send-email-tianyang.chen@oracle.com>
References: <1522094884-22718-1-git-send-email-tianyang.chen@oracle.com>
        <1522094884-22718-2-git-send-email-tianyang.chen@oracle.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Mar 2018 13:08:01 -0700
Tim Tianyang Chen <tianyang.chen@oracle.com> wrote:

> Users can define optional variables to get email notifications.
> Ktest can send emails when the script:
>  * was started
>  * failed with fatal errors and called dodie()
>  * completed all testing
> 
> Users have to setup the mailer provided in config prior to using this script.
> Supported mailers: mailx, mail, sendmail
> mailer specific routines are _sendmail_send(), _mailx_send()
> 
> Suggested-by: Dhaval Giani <dhaval.giani@oracle.com>
> Signed-off-by: Tim Tianyang Chen <tianyang.chen@oracle.com>
> 
> ---
>     changes since v2:
>     coding style fix for option maps and if statements
> 	moved sig int handeling to another patch
>     changes since v1:
>     added options for when to send emails to option_map
> ---
>  ktest.pl | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 58 insertions(+), 3 deletions(-)
> 
> diff --git a/ktest.pl b/ktest.pl
> index 0c8b61f8398e..9469783bc6c1 100755
> --- a/ktest.pl
> +++ b/ktest.pl

If you can, please use git to make your diffs.

The full path name needs to be here.

 tools/testing/ktest/ktest.pl

-- Steve

> @@ -22,6 +22,11 @@ my %evals;
>  
> 
