Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FBCECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8A120870
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YQLBD8rh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YyvdlORh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D8A120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbeGPStI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:49:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33264 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbeGPStI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:49:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3681160116; Mon, 16 Jul 2018 18:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531765232;
        bh=9teOpVWxnm593NjaRxTRqMEOUkCRFBTmu8z9T4gmXUo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YQLBD8rhM+RliTzY4LSUqf9CquIa/SRgFBWG9ReeLBkqoQQ8ZzDeZNA9RaVV7/aGb
         42UoTf+sP/q7owzmHa7tlZ7pduoAY+nWBIId/nG1c2v6EHTlfFz5Kz75CFXvciTR6s
         9qbY8JHgocwppBMPXcgXMS+p+YeW6jtuHbPFU6tE=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 2C5FF60116;
        Mon, 16 Jul 2018 18:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531765216;
        bh=9teOpVWxnm593NjaRxTRqMEOUkCRFBTmu8z9T4gmXUo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YyvdlORh0nQNwwO2tCtXZa1nqykrYVI2DKo9+zUcvcdD7V0yXUPkCaByOV+yR7FbC
         JFJDXbfktOgy+qi4WXenlNpULIF2R3ETgAClPd7MggwNRcC7ZvI5kiKMnbGzkTIuAL
         ZACf6ZnnL9vczrOgHMTi9suBbX4bKniUoRkSJyO4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 16 Jul 2018 11:20:14 -0700
From:   pheragu@codeaurora.org
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>, apw@canonical.com,
        linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        bryanh@codeaurora.org, ckadabi@codeaurora.org,
        David Keitel <dkeitel@codeaurora.org>
Subject: Re: [PATCH] checkpatch: Require commit text and warn on long commit
 text lines
In-Reply-To: <50a05aaf44e5f86cbf687863dadaa26b45debe2d.camel@perches.com>
References: <1531518027-13318-1-git-send-email-pheragu@codeaurora.org>
 <6799952fbd3639c764c112bde961b5e00270a52d.camel@perches.com>
 <6ed46f85a7577e1d4a48e81f67fd7581@codeaurora.org>
 <50a05aaf44e5f86cbf687863dadaa26b45debe2d.camel@perches.com>
Message-ID: <59a1b82fd854c9bf8a530bb053b718dc@codeaurora.org>
X-Sender: pheragu@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-13 17:08, Joe Perches wrote:
> On Fri, 2018-07-13 at 16:28 -0700, pheragu@codeaurora.org wrote:
>> On 2018-07-13 14:46, Joe Perches wrote:
>> > On Fri, 2018-07-13 at 14:40 -0700, Prakruthi Deepak Heragu wrote:
>> > > Commit text is almost always necessary to explain why a change is
>> > > needed.
>> >
>> > This bit seems sensible, but perhaps it should just count the
>> > number of lines after the end of email headers and before any
>> > Signed-off-by:/Signature line
>> >
>> 
>> While committing the changes, one can just write the subject and not
>> write
>> the commit text at all. So, if we just count the lines between email
>> headers
>> and signed-off, we still do count lines which form the subject, but 
>> the
>> commit text is still absent. Also, subject can be longer than one 
>> line.
>> So,
>> just counting lines doesn't really guarantee the presence of commit
>> text.
> 
> Not true.
> Look at $in_header_lines and $in_commit_log.
> 
>> > > Also, warn on commit text lines longer than 75 characters. The commit
>> > > text
>> > > are indented and may wrap on a terminal if they are longer than 75
>> > > characters.
>> >
>> > This is already exists via
>> >
>> > # Check for line lengths > 75 in commit log, warn once
>> > 		if ($in_commit_log && !$commit_log_long_line &&
>> > 		    length($line) > 75 &&
>> >
>> 
>> True, but this patch points out every line of the commit text that is
>> exceeding the limit.
> 
> Which is bad because things like dump_stack() are added in
> commit logs and those are already allowed to be > 75 chars.
> 
> Anyway, something like this probably works.  Please test.
> ---
>  scripts/checkpatch.pl | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index b5c875d7132b..8b5f3dae31c9 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2240,6 +2240,7 @@ sub process {
>  	my $in_header_lines = $file ? 0 : 1;
>  	my $in_commit_log = 0;		#Scanning lines before patch
>  	my $has_commit_log = 0;		#Encountered lines before patch
> +	my $commit_log_lines = 0;	#Number of commit log lines
>  	my $commit_log_possible_stack_dump = 0;
>  	my $commit_log_long_line = 0;
>  	my $commit_log_has_diff = 0;
> @@ -2497,6 +2498,18 @@ sub process {
> 
>  		$cnt_lines++ if ($realcnt != 0);
> 
> +# Verify the existence of a commit log if appropriate
> +# 2 is used because a $signature is counted in $commit_log_lines
> +		if ($in_commit_log) {
> +			if ($line !~ /^\s*$/) {
> +				$commit_log_lines++;	#could be a $signature
> +			}
> +		} else if ($has_commit_log && $commit_log_lines < 2) {
> +			WARN("COMMIT_MESSAGE",
> +			     "Missing commit description - Add an appropriate one\n");
> +			$commit_log_lines = 2;	#warn only once
> +		}
> +
>  # Check if the commit log has what seems like a diff which can confuse 
> patch
>  		if ($in_commit_log && !$commit_log_has_diff &&
>  		    (($line =~ m@^\s+diff\b.*a/[\w/]+@ &&
I checked all the cases that I mentioned before. The change you 
suggested works
for every case. Would you take care of merging this fix?
