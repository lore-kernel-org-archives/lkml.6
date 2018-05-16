Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AB8JxZp4gGvuvFcK/+KiCC34cfJV1R2timgbEXelqlU3RVUnaT+Wz9ec3zrAVaEX8/V8V/jExBoH
ARC-Seal: i=1; a=rsa-sha256; t=1526485450; cv=none;
        d=google.com; s=arc-20160816;
        b=y3ixzld/jdgvYZLltWjcZ85WUF8ntQ/AgMxOPQq+aLjZvRDTzaJqr2TetXhwil8uzO
         dVtBJsuLK/yo1ujOvqz5LLcScpeNFz1/9W0E8mSQ2NPmySczmnET+3msh5kGw3RZnOcQ
         xszNUM7VaqPW2t1gpHTDKQRwgjO0h0qRtlOa1YHcpMJw7MB9fyH1EDvMITQghbdouaZc
         0XcHih7ti1DvopjkpOyWZd+XIEmshF83ZfPZE37IvWBLjJoRDNqLI0/12g/K1l1T8BOY
         RnvDJOGphhSmXaAvMbzkeEqSd3ub60JxX0o8fzYL36QIzB/KC4Qi5ao4QY/OeY64uyUb
         XirQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=eIX2u0Ubbh8VTTOFXaW3cqLPXHNqetj5zY3828RUDT4=;
        b=wIxS2iKcbLYcdG8kgxYF+C2+9FLfUrvSE/ge78VNYgr2AY9JPf7JXv/UIyy89VRT2a
         stenwIcVFvuyS7sb3Y45gG7rpIShOiFSxTUoRp1BvEsYO0VrDFbQnxhZykdyWSXAwrjD
         AH+f3h360/TjwVT1tCVfrrG7S329npQ3GXRS7tFFcjXh5eyjzKvZg0B17lGo7LBSI/ow
         GLSU5gMTPwbh0zIOsxVC8iDprCYvCT4aXuegDaJYDiUxxHHy2FjKk1M3XiIGlYwrOp8P
         LE9E+Og/5Rt4odV/+qjzxP1L3Ft1YoAcFM9Y6QMnO1tBd7UUS8QGWbZZLPldYeUxEo/T
         QJjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.14 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.14 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2197:2198:2199:2200:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:4321:4605:5007:6119:7903:8957:10004:10400:10848:11026:11232:11658:11914:12043:12296:12555:12740:12760:12895:13439:13548:14181:14659:14721:21080:21221:21451:21611:21627:30054:30060:30064:30070:30090:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: food04_4133b5360b443
X-Filterd-Recvd-Size: 3861
Message-ID: <e889f1ece72522303916a755d2dfac507de07de9.camel@perches.com>
Subject: Re: [PATCH 4/4] staging: lustre: obdclass: change object lookup to
 no wait mode
From: Joe Perches <joe@perches.com>
To: "Dilger, Andreas" <andreas.dilger@intel.com>, Dan Carpenter
	 <dan.carpenter@oracle.com>
Cc: James Simmons <jsimmons@infradead.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "devel@driverdev.osuosl.org"
 <devel@driverdev.osuosl.org>, "Drokin, Oleg" <oleg.drokin@intel.com>,
 "Siyao, Lai" <lai.siyao@intel.com>, NeilBrown <neilb@suse.com>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Lustre Development List
 <lustre-devel@lists.lustre.org>
Date: Wed, 16 May 2018 08:44:06 -0700
In-Reply-To: <EDCE6E68-0B5C-4F82-B356-8D70AE5FF92A@intel.com>
References: <1525285308-15347-1-git-send-email-jsimmons@infradead.org>
	 <1525285308-15347-5-git-send-email-jsimmons@infradead.org>
	 <20180508114500.qrtnjax4siupgv3n@mwanda>
	 <alpine.LFD.2.21.1805150207500.576@casper.infradead.org>
	 <20180516080022.b4ihz7opiueobm7u@mwanda>
	 <EDCE6E68-0B5C-4F82-B356-8D70AE5FF92A@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599377578642480087?=
X-GMAIL-MSGID: =?utf-8?q?1600636007837579908?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-05-16 at 09:12 +0000, Dilger, Andreas wrote:
> On May 16, 2018, at 02:00, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > 
> > On Tue, May 15, 2018 at 04:02:55PM +0100, James Simmons wrote:
> > > 
> > > > > 	/*
> > > > > 	 * Allocate new object. This may result in rather complicated
> > > > > 	 * operations, including fld queries, inode loading, etc.
> > > > > 	 */
> > > > > 	o = lu_object_alloc(env, dev, f, conf);
> > > > > -	if (IS_ERR(o))
> > > > > +	if (unlikely(IS_ERR(o)))
> > > > > 		return o;
> > > > > 
> > > > 
> > > > This is an unrelated and totally pointless.  likely/unlikely annotations
> > > > hurt readability, and they should only be added if it's something which
> > > > is going to show up in benchmarking.  lu_object_alloc() is already too
> > > > slow for the unlikely() to make a difference and anyway IS_ERR() has an
> > > > unlikely built in so it's duplicative...
> > > 
> > > Sounds like a good checkpatch case to test for :-)
> > 
> > The likely/unlikely annotations have their place in fast paths so a
> > checkpatch warning would get annoying...
> 
> I think James was suggesting a check for unlikely(IS_ERR()),

Probably so.

$ git grep -P 'likely\s*\(\s*\!?\s*IS_ERR' | wc -l
42

Are there other known likely/unlikely duplications?

>  or possibly
> a check for unlikely() on something that is already unlikely() after CPP
> expansion.

checkpatch isn't the tool for that type of test
as it is a collection of trivial regex tests and
it is not a c90 preprocessor.

Anyway, here's a possible checkpatch patch.
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index baddac9379f0..20c0973f1c39 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6299,6 +6299,12 @@ sub process {
 			      "#define of '$1' is wrong - use Kconfig variables or standard guards instead\n" . $herecurr);
 		}
 
+# likely/unlikely tests with IS_ERR (already unlikely)"
+		if ($line =~ /\b((?:un)?likely)\s*\(\s*\!?\s*(IS_ERR[A-Z_]*)\s*\(/) {
+			WARN("DUPLICATE_LIKELY",
+			     "Unnecessary use of $1 with $2 as it already has an unlikely\n" . $herecurr);
+		}
+
 # likely/unlikely comparisons similar to "(likely(foo) > 0)"
 		if ($^V && $^V ge 5.10.0 &&
 		    $line =~ /\b((?:un)?likely)\s*\(\s*$FuncArg\s*\)\s*$Compare/) {
