Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A04A0C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C18920020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eXioRuYy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C18920020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935696AbeFMNLp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:11:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46828 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935346AbeFMNLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:11:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5DD9jjp049439;
        Wed, 13 Jun 2018 13:11:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=qT5zajnJ7ai2N9SSUBL0clqojCxw8AwE4ZN17QNl3Kg=;
 b=eXioRuYyVVRPweJodDp8fQj6WsrGb5gTjPMBNfBWnJgnEWwG9TONRl8BO3+ir0eUMfTH
 a1gBS8/bTcvbRdQTJPKo8dhZGKBfxqn4s0Hm9KFO0HHyy9jGsWV4TJeVFymLQDSwp+ay
 QK34DiSrmvEDEQzywukxIW14e3/0e5fSz+rV5x6fcCHC1d9nhcsNz7N3b3voDrK4dgUV
 cFb1TvskIwqPM8vJR9oo8HcwmwueQyjMlX3NLSAH00jgIYYlPIc5tZseyr4e2TztWGl9
 x+w8qpHMMneh2OuKsZPT5jX//GHdzOPzt025+uaUg0+WEgR+K9y27q/S7cZd/RpofQiX gQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2jk0xr8mjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 13:11:02 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5DDB1XW029813
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 13:11:02 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5DDB1aG022649;
        Wed, 13 Jun 2018 13:11:01 GMT
Received: from mwanda (/197.157.34.169)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Jun 2018 06:11:01 -0700
Date:   Wed, 13 Jun 2018 16:10:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: Smatch check for Spectre stuff
Message-ID: <20180613131049.sf7abp6wwrnpy5ct@mwanda>
References: <20180419051510.GA21898@mwanda>
 <20180608161219.q3lwvlydvs4l2gxa@treble>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4mpsdi3lywj2u6b4"
Content-Disposition: inline
In-Reply-To: <20180608161219.q3lwvlydvs4l2gxa@treble>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8922 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806130144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4mpsdi3lywj2u6b4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 08, 2018 at 11:12:19AM -0500, Josh Poimboeuf wrote:
> I have a few questions/comments.
> 
> 1) I've noticed a common pattern for many of the false positives.
>    Smatch doesn't seem to detect when the code masks off the array index
>    to ensure that it's safe.
> 
>    For example:
> 
>    > ./include/linux/mmzone.h:1161 __nr_to_section() warn: potential spectre issue 'mem_section[(nr / (((1) << 12) / 32))]'
> 
>    1153 static inline struct mem_section *__nr_to_section(unsigned long nr)
>    1154 {
>    1155 #ifdef CONFIG_SPARSEMEM_EXTREME
>    1156         if (!mem_section)
>    1157                 return NULL;
>    1158 #endif
>    1159         if (!mem_section[SECTION_NR_TO_ROOT(nr)])
>    1160                 return NULL;
>    1161         return &mem_section[SECTION_NR_TO_ROOT(nr)][nr & SECTION_ROOT_MASK];
>    1162 }
> 
>    In the 2-D array access, it seems to be complaining about the '[nr &
>    SECTION_ROOT_MASK]' reference.  But that appears to be safe because
>    all the unsafe bits are masked off.
>  
>    It would be great if Smatch could detect that situation if possible.

I can try.  The thing is that it would have to be masked within the same
function because that information isn't passed across the function
calls.

Also it turns out that mem_section[] is declared in mm/sparse.c and
Smatch is supposed to be able to figure out the size of it but
apparently there is a bug...  :(  I'll take a look at that.

> 
> 2) Looking at the above example, it seems that the value of 'nr' is
>    untrusted.  If so, then I wonder why didn't it warn about the other
>    array accesses in the function: line 1559 and the first dimension
>    access in 1161?

Good point.  I'll change that as well.

> 
> 3) One thing that I think would help with analyzing the results would be
>    if there was a way to see the call chain for each warning, so that
>    it's clear which value isn't trusted and why.

The information is mostly there in the cross function DB, but the user
interface is bad...  Use the smdb.py script to see how functions are
called:

	 ~/smatch/smatch_data/db/smdb.py __nr_to_section

> 
> 4) Is there a way to put some results in a whitelist to mark them as
>    false positives so they won't show up in future scans?  Something
>    like that would help with automatic detection and reporting of new
>    issues by the 0-day kbuild test robot, for example.

There is a script called smatch_scripts/new_bugs.sh but I use a
different new_bugs.sh script which I am embarrassed to publish.  I guess
I'll attach it though.

regards,
dan carpenter



--4mpsdi3lywj2u6b4
Content-Type: application/x-sh
Content-Disposition: attachment; filename="new_bugs.sh"
Content-Transfer-Encoding: quoted-printable

#!/usr/bin/perl=0A=0Ause strict;=0A=0Amy $store =3D 0;=0Amy $unstore =3D 0;=
=0Amy $warns_file =3D shift;=0Aif ($warns_file =3D~ /--store/) {=0A    $sto=
re =3D 1;=0A    $warns_file =3D shift;=0A}=0Aif ($warns_file =3D~ /--unstor=
e/) {=0A    $unstore =3D 1;=0A    $warns_file =3D shift;=0A}=0A=0Amy $du =
=3D `du $warns_file`;=0A$du =3D~ s/([0-9]+).*/$1/;=0A$du =3D~ s/\n//;=0A=0A=
if (int($du) > 100000) {=0A    print "$warns_file is too big\n";=0A    exit=
(1);=0A}=0A=0Aopen(WARNS, $warns_file);=0A=0Amy ($orig, $file, $line, $msg)=
;=0Awhile (<WARNS>) {=0A=0A    if (!($_ =3D~ /(error|warn|info)/)) {=0A    =
    next;=0A    }=0A=0A    $orig =3D $_;=0A    ($file, $line, $msg) =3D spl=
it(/[: ]/, $_, 3);=0A=0A    $msg =3D~ s/^.*?:\d+(|:\d+:) .*? //;=0A    $msg=
 =3D~ s/[us](16|32|64)(min|max)//g;=0A    $msg =3D~ s/[01234567890]//g;=0A =
   if ($msg =3D~ /can't/) {=0A        $msg =3D~ s/(.*can't.*').*?('.*)/$1 $=
2/;=0A    } elsif ($msg =3D~ /don't/) {=0A        $msg =3D~ s/(.*don't.*').=
*?('.*)/$1 $2/;=0A    } else {=0A        $msg =3D~ s/'.*?'/''/g;=0A    }=0A=
    $msg =3D~ s/,//g;=0A    $msg =3D~ s/\(\w+ returns null\)/(... returns n=
ull)/;=0A    $msg =3D~ s/dma on the stack \(.*?\)/dma on the stack (...)/;=
=0A    $msg =3D~ s/possible ERR_PTR '' to .*/possible ERR_PTR '' to .../;=
=0A    $msg =3D~ s/inconsistent returns ([^ ]+?) locked \(\)/inconsistent r=
eturns ... locked ()/;=0A    $msg =3D~ s/(.*) [^ ]* (too large for) [^ ]+ (=
=2E*)/$1 $2 $3/;=0A    $msg =3D~ s/\n//;=0A    $msg =3D~ s/ /_/g;=0A    $ms=
g =3D~ s/[\(\)]//g;=0A=0A    $file =3D~ s/\//./g;=0A    $msg =3D~ s/\//./g;=
=0A=0A    if ($store) {=0A        open(TMP, '>', "old_warnings/$file.$msg")=
 or=0A            print "Error opening: old_warnings/$file.$msg\n";=0A     =
   close(TMP);=0A        next;=0A    }=0A=0A    if ($unstore) {=0A        u=
nlink("old_warnings/$file.$msg") and=0A            print "removed: old_warn=
ings/$file.$msg\n";=0A        next;=0A    }=0A=0A    unless (-e "old_warnin=
gs/$file.$msg") {=0A        print "$orig";=0A    }=0A}=0A=0Aclose(WARNS);=0A
--4mpsdi3lywj2u6b4--
