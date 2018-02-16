Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034538AbeBPOwn convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 09:52:43 -0500
Received: from smtp3-1.goneo.de ([85.220.129.38]:42656 "EHLO smtp3-1.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034503AbeBPOwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 09:52:40 -0500
X-Spam-Flag: NO
X-Spam-Score: -2.801
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 4/6] scripts: kernel-doc: support in-line comments on
 nested structs/unions
From: Markus Heiser <markus.heiser@darmarit.de>
In-Reply-To: <a4f7680bf956e6c98f612bcfc7aa817c344ebdab.1518788761.git.mchehab@s-opensource.com>
Date: Fri, 16 Feb 2018 15:52:33 +0100
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Jani Nikula <jani.nikula@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <54EF06CB-C31F-476D-B674-579E9385D635@darmarit.de>
References: <cover.1518788761.git.mchehab@s-opensource.com>
 <cover.1518788761.git.mchehab@s-opensource.com>
 <a4f7680bf956e6c98f612bcfc7aa817c344ebdab.1518788761.git.mchehab@s-opensource.com>
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 16.02.2018 um 14:48 schrieb Mauro Carvalho Chehab <mchehab@s-opensource.com>:
> 
> The parser at kernel-doc rejects names with dots in the middle.
> Fix it, in order to support nested structs/unions.
> 
> Tested-by: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> ---
> scripts/kernel-doc | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index fee8952037b1..06d7f3f2c094 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -363,7 +363,7 @@ my $doc_sect = $doc_com .
> my $doc_content = $doc_com_body . '(.*)';
> my $doc_block = $doc_com . 'DOC:\s*(.*)?';
> my $doc_inline_start = '^\s*/\*\*\s*$';
> -my $doc_inline_sect = '\s*\*\s*(@[\w\s]+):(.*)';
> +my $doc_inline_sect = '\s*\*\s*(@\s*[\w][\w\.]*\s*):(.*)';

Thanks!

FWIW: added similar patch to python variant of kernel-doc:

https://github.com/return42/linuxdoc/commit/5c5da9a

rendered example:

  https://return42.github.io/linuxdoc/linuxdoc-howto/all-in-a-tumble.html#struct-my-long-struct

-- Markus --
