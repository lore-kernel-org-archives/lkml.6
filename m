Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751661AbeCVSaQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 14:30:16 -0400
Received: from smtprelay0022.hostedemail.com ([216.40.44.22]:54551 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751140AbeCVSaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 14:30:14 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:541:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3871:3872:3873:3874:4321:4605:5007:6119:7875:7903:10004:10400:10848:11026:11232:11658:11914:12296:12681:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21433:21451:21627:30046:30054:30080:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: bell63_3bf6d6c4a0421
X-Filterd-Recvd-Size: 2505
Message-ID: <1521743410.7999.48.camel@perches.com>
Subject: Re: [PATCH 2/2] fpga: lattice machxo2: Add Lattice MachXO2 support
From: Joe Perches <joe@perches.com>
To: Paolo Pisati <p.pisati@gmail.com>
Cc: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Thu, 22 Mar 2018 11:30:10 -0700
In-Reply-To: <20180322172608.GA22179@harukaze>
References: <1521653726-24625-1-git-send-email-p.pisati@gmail.com>
         <1521653726-24625-3-git-send-email-p.pisati@gmail.com>
         <1521655492.7999.13.camel@perches.com> <20180322172608.GA22179@harukaze>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-22 at 18:26 +0100, Paolo Pisati wrote:
> > It's frequently nicer to use a static function
> > for these enum -> string conversions like:
> > 
> > static const char *get_err_string(unsigned long err)
> > {
> > 	switch (err) {
> > 	case ENOERR:	return "No Error";
> > 	case EID:	return "ID ERR";
> > 	case ECMD:	return "CMD ERR";
> > 	[...]
> > 	}
> > 	return "default switch case";
> > }
> 
> Ok - checkpatch complained when i put the "case ...: return ...;" on the same
> line as you did here, that is why i ended up with the ugly "case...: $string;
> break" all on different lines

checkpatch is brainless and stupid and if it
recommends stupid consistency over readability,
ignore it.
 
> > > +	pr_debug("machxo2 status: 0x%08lX - done=%d, cfgena=%d, busy=%d, fail=%d, devver=%d, err=%s\n",
> > > +	       *status, test_bit(DONE, status), test_bit(ENAB, status),
> > > +	       test_bit(BUSY, status), test_bit(FAIL, status),
> > > +		   test_bit(DVER, status), ferr);
> > 
> > So instead of ferr, this could use
> > 	get_err_string(*status)
> > 
> > And please try to keep a consistent alignment for
> > indentation of multiple line statements
> 
> I tried, but then checkpatch complained again about the indentation of the above block
> and i literally had to guess...

I think it only complained about the
2nd line that starts *status because it
doesn't align with the open parenthesis
of pr_debug
