Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55AFC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A76520894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A76520894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731766AbeG3UZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 16:25:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49480 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728746AbeG3UZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 16:25:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9F2B240216FE;
        Mon, 30 Jul 2018 18:48:48 +0000 (UTC)
Received: from redhat.com (ovpn-123-16.rdu2.redhat.com [10.10.123.16])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5BEE9111AF0C;
        Mon, 30 Jul 2018 18:48:48 +0000 (UTC)
Date:   Mon, 30 Jul 2018 14:48:48 -0400
From:   Don Zickus <dzickus@redhat.com>
To:     Joe Perches <joe@perches.com>
Cc:     Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org,
        jtoppins@redhat.com
Subject: Re: [PATCH] get_maintainer.pl: Add optional
 .get_maintainer.MAINTAINERS override
Message-ID: <20180730184848.uooedven2od666hs@redhat.com>
References: <c187fe5040cb616292dab6c106352273df95bc41.camel@perches.com>
 <20180706184411.ilzbt7fxuje2nhx6@redhat.com>
 <716eb88d-31ac-c488-f799-dec9c9afb5af@redhat.com>
 <948af2d06623e8fcca6f0c0fd300a65bbfd1c6fa.camel@perches.com>
 <20180706215851.sqpibusyqukbh55g@redhat.com>
 <5ebb181efcdd2cdb3c1ee8eac9bba26f5759a0ea.camel@perches.com>
 <9efeba75a47e9b0c40d5b9e5078598ff4a31f196.camel@perches.com>
 <20180713185109.hanjstgdvl2fw4ry@redhat.com>
 <751491f9b9d7ce18f048ba44fbdb17d8c699e674.camel@perches.com>
 <20180716212019.sjxyxqeltgdcuqqr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716212019.sjxyxqeltgdcuqqr@redhat.com>
User-Agent: NeoMutt/20180622
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 30 Jul 2018 18:48:48 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 30 Jul 2018 18:48:48 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dzickus@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 05:20:19PM -0400, Don Zickus wrote:
> On Fri, Jul 13, 2018 at 05:11:58PM -0700, Joe Perches wrote:
> > On Fri, 2018-07-13 at 14:51 -0400, Don Zickus wrote:
> > > On Fri, Jul 06, 2018 at 03:14:28PM -0700, Joe Perches wrote:
> > > > On Fri, 2018-07-06 at 15:09 -0700, Joe Perches wrote:
> > > > > On Fri, 2018-07-06 at 17:58 -0400, Don Zickus wrote:
> > > > > > We have an internal use case of multiple MAINTAINER files, some folks have
> > > > > > more rights to patches than others so they are not allowed to be cc'd (think
> > > > > > embargoed stuff).
> > > > 
> > > > How about:
> > > 
> > > Hi Joe,
> > > 
> > > You are probably busy with stuff, but wanted to softly poke you to see what
> > > is going on with this patch and if there is anything we can help with?
> > 
> > Hey Don.  No worries.
> > 
> > Tell me again if the --find-maintainer-files=<path or file> should
> > be exclusive or should it also read any existing MAINTAINERS file?
> 
> Hi Joe,
> 
> We were looking for it to be exclusive.  If we backport a patch, we want our
> internal maintainers to be cc'd not the upstream maintainers.  I don't think
> upstream needs any more spam. :-)

Hi Joe,

ping?  Any feedback here?

Cheers,
Don

> 
> > 
> > What if anything is wrong with what I suggested?
> 
> You posted multiple versions of a similar patch, each needed some
> tweaks.  But were pretty close to working.
> 
> If I had a <dir> with a MAINTAINERS directory beneath it with files behind
> that, I just wanted to run:
> 
> get_maintainers.pl --find-maintainer-files <dir>/  # find <dir>/MAINTAINERS/
> get_maintainers.pl --find-maintainer-files <dir>/MAINTAINER/<file>  # restricted list
> 
> That's it.  I attached a patch you provided that worked for me. I added a
> 
> +  push(@mfiles, "${path}") if -f "${path}";
> 
> to your last version of the patch to get things working for me.  You may
> want a different solution there.
> 
> Cheers,
> Don
> 
> ---
>  scripts/get_maintainer.pl | 39 +++++++++++++++++++++------------------
>  1 file changed, 21 insertions(+), 18 deletions(-)
> 
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index c87fa734e3e1..f7a7d46340a8 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -60,7 +60,7 @@ my $pattern_depth = 0;
>  my $self_test = undef;
>  my $version = 0;
>  my $help = 0;
> -my $find_maintainer_files = 0;
> +my $find_maintainer_files;
>  
>  my $vcs_used = 0;
>  
> @@ -262,7 +262,7 @@ if (!GetOptions(
>  		'sections!' => \$sections,
>  		'fe|file-emails!' => \$file_emails,
>  		'f|file' => \$from_filename,
> -		'find-maintainer-files' => \$find_maintainer_files,
> +		'find-maintainer-files:s' => \$find_maintainer_files,
>  		'self-test:s' => \$self_test,
>  		'v|version' => \$version,
>  		'h|help|usage' => \$help,
> @@ -384,26 +384,30 @@ sub find_ignore_git {
>  read_all_maintainer_files();
>  
>  sub read_all_maintainer_files {
> -    if (-d "${lk_path}MAINTAINERS") {
> -        opendir(DIR, "${lk_path}MAINTAINERS") or die $!;
> -        my @files = readdir(DIR);
> -        closedir(DIR);
> -        foreach my $file (@files) {
> -            push(@mfiles, "${lk_path}MAINTAINERS/$file") if ($file !~ /^\./);
> -        }
> -    }
> -
> -    if ($find_maintainer_files) {
> -        find( { wanted => \&find_is_maintainer_file,
> -                preprocess => \&find_ignore_git,
> -                no_chdir => 1,
> -        }, "${lk_path}");
> +    my $path = defined $find_maintainer_files && $find_maintainer_files ne ""
> +	? $find_maintainer_files : $lk_path;
> +    if (-d "${path}MAINTAINERS") {
> +	opendir(DIR, "${path}MAINTAINERS") or die $!;
> +	my @files = readdir(DIR);
> +	closedir(DIR);
> +	foreach my $file (@files) {
> +	    push(@mfiles, "${path}MAINTAINERS/$file") if ($file !~ /^\./);
> +	}
> +    }
> +
> +    if (defined $find_maintainer_files && (-d $find_maintainer_files)) {
> +	find( { wanted => \&find_is_maintainer_file,
> +		preprocess => \&find_ignore_git,
> +		no_chdir => 1,
> +	      }, "${path}");
>      } else {
> -        push(@mfiles, "${lk_path}MAINTAINERS") if -f "${lk_path}MAINTAINERS";
> +	push(@mfiles, "${path}MAINTAINERS") if -f "${path}MAINTAINERS";
> +	push(@mfiles, "${path}") if -f "${path}";
>      }
>  
> +    die "$P: No MAINTAINER files found in $path\n" if (scalar(@mfiles) == 0);
>      foreach my $file (@mfiles) {
> -        read_maintainer_file("$file");
> +	read_maintainer_file("$file");
>      }
>  }
>  
