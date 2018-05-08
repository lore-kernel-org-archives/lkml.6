Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755650AbeEHTFY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 15:05:24 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:39508 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755186AbeEHTFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 15:05:22 -0400
X-Google-Smtp-Source: AB8JxZrBNbVin+nbe/UukNbUUFXsi2wsJvsZPHSJ2pY/dG3ZXmAAwTClvUyni0nSM+GTkQSIaOTCrQ==
Date: Tue, 8 May 2018 21:05:05 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Jeff Layton <jlayton@redhat.com>, Randy Dunlap <rdunlap@infradead.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [PATCH 05/18] docs: core-api: add cachetlb documentation
Message-ID: <20180508190505.GA12213@andrea>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
 <07b59879d34502828467f0190f941e23e08fdc81.1525684985.git.mchehab+samsung@kernel.org>
 <20180507122937.GA5813@andrea>
 <87y3gu43d3.fsf@intel.com>
 <20180508150507.284ef477@vento.lan>
 <20180508152851.11f39370@vento.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508152851.11f39370@vento.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 03:28:51PM -0300, Mauro Carvalho Chehab wrote:
> Em Tue, 8 May 2018 15:05:07 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> escreveu:
> 
> > Em Tue, 08 May 2018 17:40:56 +0300
> > Jani Nikula <jani.nikula@linux.intel.com> escreveu:

[...]

> > > Side note, there's scripts/documentation-file-ref-check to grep the
> > > kernel tree for things that look like file references to Documentation/*
> > > and complain if they don't exist.
> > > 
> > > I get about 350+ hits with that, patches welcome! ;)  
> > 
> > This small script fixes a bunch of such errors:
> > 
> > 	scripts/documentation-file-ref-check 2>broken_refs
> > 	for i in $(cat broken_refs|cut -d: -f 2|grep -v devicetree|sort|uniq|grep \\.txt); do
> > 	        rst=$(basename $i)
> > 	        rst=${rst/.txt/.rst}
> > 	        f=$(find . -name $rst)
> > 	        f=${f#./}
> > 	        if [ "$f" != "" ]; then
> > 	                echo "Replacing $i to $f"
> > 	                for j in $(git grep -l $i); do
> > 	                        sed "s@$i@$f@g" -i $j
> > 	                done
> > 	        fi
> > 	done
> 
> It follows an improvement to the above script that shows also what
> it didn't find as a ReST file, and the ones that have common names
> with multiple matches.
> 
> I guess we could integrate something like that at 
> scripts/documentation-file-ref-check, in order to allow auto-correcting
> renamed .txt files.

FWIW, this would be more than welcome with me; thank you,

  Andrea


> 
> Regards,
> Mauro
> 
> 
> #!/bin/bash
> 
> scripts/documentation-file-ref-check 2>broken_refs
> for i in $(cat broken_refs|cut -d: -f 2|grep -v devicetree|sort|uniq|grep \\.txt); do
>         rst=$(basename $i)
>         rst=${rst/.txt/.rst}
>         f=$(find . -name $rst)
> 
>         if [ "$f" == "" ]; then
>                 echo "ERROR: Didn't find a .rst replacement for $i"
>         elif [ "$(echo $f | grep ' ')" != "" ]; then
>                 echo "ERROR: Found multiple possible replacements for $i:"
>                 for j in $f; do
>                         echo "    $j"
>                 done
>         else
>                 echo "Replacing $i to $f"
>                 f=${f#./}
>                 for j in $(git grep -l $i); do
>                         sed "s@$i@$f@g" -i $j
>                 done
>         fi
> done
> 
> 
> Thanks,
> Mauro
