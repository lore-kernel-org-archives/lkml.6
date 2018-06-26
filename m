Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C96C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 22:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FCE26B9E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 22:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1FCE26B9E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754847AbeFZWwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 18:52:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35544 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751143AbeFZWwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 18:52:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F218A40201CE;
        Tue, 26 Jun 2018 22:52:37 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw.lab.eng.bos.redhat.com [10.16.186.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3B512026D6A;
        Tue, 26 Jun 2018 22:52:37 +0000 (UTC)
Subject: Re: [PATCH] get_maintainer.pl: Add optional
 .get_maintainer.MAINTAINERS override
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     dzickus@redhat.com, jtoppins@redhat.com
References: <20180626182505.4176-1-prarit@redhat.com>
 <601f0e6bf3baa88b9f6145e635d728a435542292.camel@perches.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <98fe3602-864a-3963-ac56-a743f1b61700@redhat.com>
Date:   Tue, 26 Jun 2018 18:52:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <601f0e6bf3baa88b9f6145e635d728a435542292.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 26 Jun 2018 22:52:38 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 26 Jun 2018 22:52:38 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'prarit@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/26/2018 04:16 PM, Joe Perches wrote:
> On Tue, 2018-06-26 at 14:25 -0400, Prarit Bhargava wrote:
>> OSes have additional maintainers that should be cc'd on patches or may
>> want to circulate internal patches.
>>
>> Parse the .get_maintainer.MAINTAINERS file.  Entries in the file
>> can begin with a '+' to indicate the email and list entries should be
>> added to the exiting MAINTAINERS output, or a '-' to indicate that the
>> entries should override the existing MAINTAINERS file.
>>
>> Also add a help entry for the .get_maintainers.ignore file.
> 
> I see no reason for this patch to be applied.
> Why should it?

The kernel has other vendor/OS changes like my patch, for example, 4efb442cc12e
("kernel/panic.c: add TAINT_AUX").  From that commit message

    Add an auxiliary taint flag to be used by distros and others.  This
    obviates the need to forward-port whatever internal solutions people
    have in favor of a single flag which they can map arbitrarily to a
    definition of their pleasing.

The same principle should be applied to my patch in that distros no longer would
need to forward-port internal solutions similar to this.

> Why shouldn't this be in your private repository?

If you don't want it I'll carry it forward but that's a loss for both of us, and
as pointed out in the above commit, other distros.  If you do want to reject the
patch please let me know and I'll only submit the "get_maintainer.ignore" help
chunk.

P.
> 
>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>> Cc: Joe Perches <joe@perches.com>
>> Cc: dzickus@redhat.com
>> Cc: jtoppins@redhat.com
>> ---
>>  scripts/get_maintainer.pl | 34 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 34 insertions(+)
>>
>> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
>> index c87fa734e3e1..239f4d2ce972 100755
>> --- a/scripts/get_maintainer.pl
>> +++ b/scripts/get_maintainer.pl
>> @@ -384,6 +384,32 @@ sub find_ignore_git {
>>  read_all_maintainer_files();
>>  
>>  sub read_all_maintainer_files {
>> +	my $conf = which_conf(".get_maintainer.MAINTAINERS");
>> +	if ( -f $conf) {
>> +	    my @conf_args;
>> +	    my $add = 0;
>> +	    open(my $conffile, '<', "$conf")
>> +		or warn "$P: Can't find a readable .get_maintainer.MAINTAINERS file $!\n";
>> +	    while (<$conffile>) {
>> +		my $line = $_;
>> +		if ($line =~ m/^\+/ ) {
>> +		    $add = 1;
>> +		}
>> +		next if ($line =~ m/^\s*#/);
>> +		$line =~ s/^\+//g;
>> +		$line =~ s/^\-//g;
>> +		$line =~ s/\s*\n?$//;
>> +		push(@mfiles, $line);
>> +	    }
>> +	    close($conffile);
>> +	    if ($add eq 0) {
>> +		foreach my $file (@mfiles) {
>> +		     read_maintainer_file("$file");
>> +		}
>> +		return;
>> +	    }
>> +	}
>> +
>>      if (-d "${lk_path}MAINTAINERS") {
>>          opendir(DIR, "${lk_path}MAINTAINERS") or die $!;
>>          my @files = readdir(DIR);
>> @@ -1068,6 +1094,14 @@ Notes:
>>        Entries in this file can be any command line argument.
>>        This file is prepended to any additional command line arguments.
>>        Multiple lines and # comments are allowed.
>> +  File ".get_maintainer.ignore", if it exists in the linux kernel source root
>> +      directory, can contain a list of email addresses to ignore.  Multiple
>> +      lines and # comments are allowed.
>> +  File ".get_maintainer.MAINTAINERS", if it exists in the linux kernel source
>> +      root directory, can change the location of the MAINTAINERS file.
>> +      Entries beginning with a '+' are added to the default list, and
>> +      entries beginning with a '-' override the existing MAINTAINERS list
>> +      lookup.  Multiple lines and # comments are allowed.
>>    Most options have both positive and negative forms.
>>        The negative forms for --<foo> are --no<foo> and --no-<foo>.
>>  
