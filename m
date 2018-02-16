Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034621AbeBPO5H (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 09:57:07 -0500
Received: from osg.samsung.com ([64.30.133.232]:36896 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033834AbeBPO5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 09:57:06 -0500
Date: Fri, 16 Feb 2018 12:56:51 -0200
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Markus Heiser <markus.heiser@darmarit.de>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH 4/6] scripts: kernel-doc: support in-line comments on
 nested structs/unions
Message-ID: <20180216125651.45401575@vento.lan>
In-Reply-To: <54EF06CB-C31F-476D-B674-579E9385D635@darmarit.de>
References: <cover.1518788761.git.mchehab@s-opensource.com>
        <cover.1518788761.git.mchehab@s-opensource.com>
        <a4f7680bf956e6c98f612bcfc7aa817c344ebdab.1518788761.git.mchehab@s-opensource.com>
        <54EF06CB-C31F-476D-B674-579E9385D635@darmarit.de>
Organization: Samsung
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 16 Feb 2018 15:52:33 +0100
Markus Heiser <markus.heiser@darmarit.de> escreveu:

> > Am 16.02.2018 um 14:48 schrieb Mauro Carvalho Chehab <mchehab@s-opensource.com>:
> > 
> > The parser at kernel-doc rejects names with dots in the middle.
> > Fix it, in order to support nested structs/unions.
> > 
> > Tested-by: Jani Nikula <jani.nikula@intel.com>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> > ---
> > scripts/kernel-doc | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> > index fee8952037b1..06d7f3f2c094 100755
> > --- a/scripts/kernel-doc
> > +++ b/scripts/kernel-doc
> > @@ -363,7 +363,7 @@ my $doc_sect = $doc_com .
> > my $doc_content = $doc_com_body . '(.*)';
> > my $doc_block = $doc_com . 'DOC:\s*(.*)?';
> > my $doc_inline_start = '^\s*/\*\*\s*$';
> > -my $doc_inline_sect = '\s*\*\s*(@[\w\s]+):(.*)';
> > +my $doc_inline_sect = '\s*\*\s*(@\s*[\w][\w\.]*\s*):(.*)';  
> 
> Thanks!
> 
> FWIW: added similar patch to python variant of kernel-doc:
> 
> https://github.com/return42/linuxdoc/commit/5c5da9a
> 
> rendered example:
> 
>   https://return42.github.io/linuxdoc/linuxdoc-howto/all-in-a-tumble.html#struct-my-long-struct

On a quick look, on your example, bar2.barbar description looks different
than what we get from the perl version.

There, it generates it as:

``bar2.barbar``
  Description for **barbar** inside **foo.bar2**

Regards,
Mauro
