Return-Path: <corbet@lwn.net>
X-Google-Smtp-Source: AB8JxZoJ8/pJ5Eh5Zt3Ip8disp7HsCgmg0NN74Dd7UReH8Kwe6wDuu4IqIhg6xyngInYHDT55k5A
ARC-Seal: i=1; a=rsa-sha256; t=1527082759; cv=none;
        d=google.com; s=arc-20160816;
        b=Y7Udl57UhXZ8rBENeD45B5q0Pzjri3TwnvGq/JGJkhIHpHieX4k4oT5Y3kLNI0/4Ue
         f+M4sswhpyYVuoxXyuAP2L1HHQrQNPgFTFFvJF7viAaCCkwR4mqEGFQMCL83CzJGo5Rf
         VNOD22ugwe5Y8XfhGQ+UpuoF7SFE2drMCGCdLWAw4QqHwuUqZVdYusfJQSY4hL2SeBzD
         pc4TTJb6ua8SDZHRNW5hkw5qJ01+77/c32CQXZDBwLcMkp8RZEBaEAOBJYxoS4659Qar
         8gIYkYssQcvxJGs5x3H+XnR0bUTUlbQXgl/r75jliaQ5pDUrew35ggDh3WwvF9qAP0ql
         Nddw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=i418kl3FlxhKi2P/e0q4l7OW6b7fvJN3TprQYyZvR1s=;
        b=lpgpoymsaH3AiL71X4p/XHo9p0F4d3a8aYxyTO1IEKlYg+6Pfxs4rRi8t1NiLVBh9H
         IKD7kKXKKCaFs1bYI2lqvO4knB55TPcdmsIfSKOljwwgREHhSSuYCwOtkpP73V5B1Qgf
         2BnXtOcBreHwXGaCN1eCYw9iR1RB8N1lMgvWkLJbrO79ENDb2ZThsVGE6XzkfW72gmzJ
         79q0TKymx/94LTCW0yzSI/xlumyzN6PBoiBNMHx0BDLqHWp9gagskex/JSo4vZlXQX4R
         o838KeBr0GwK+anPEkhcH/f1RMhc4U9orKBeCyDOb+26JwGkFL74u7frsSjfgmePmGrP
         GaUA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Date: Wed, 23 May 2018 07:39:17 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
 akpm@linux-foundation.org, willy@infradead.org, gregkh@linuxfoundation.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 dev@openvswitch.org, shli@kernel.org, linux-raid@vger.kernel.org
Subject: Re: [PATCH 6/6] Drop flex_arrays
Message-ID: <20180523073917.618db21a@lwn.net>
In-Reply-To: <20180523011821.12165-6-kent.overstreet@gmail.com>
References: <20180523011821.12165-1-kent.overstreet@gmail.com>
	<20180523011821.12165-6-kent.overstreet@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601215747530067886?=
X-GMAIL-MSGID: =?utf-8?q?1601262331598165276?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 22 May 2018 21:18:21 -0400
Kent Overstreet <kent.overstreet@gmail.com> wrote:

> All existing users have been converted to generic radix trees
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> ---
>  Documentation/core-api/flexible-arrays.rst | 130 -------
>  Documentation/flexible-arrays.txt          | 123 -------
>  include/linux/flex_array.h                 | 149 --------
>  include/linux/poison.h                     |   3 -
>  lib/Makefile                               |   2 +-
>  lib/flex_array.c                           | 398 ---------------------
>  tools/include/linux/poison.h               |   3 -
>  7 files changed, 1 insertion(+), 807 deletions(-)
>  delete mode 100644 Documentation/core-api/flexible-arrays.rst
>  delete mode 100644 Documentation/flexible-arrays.txt
>  delete mode 100644 include/linux/flex_array.h
>  delete mode 100644 lib/flex_array.c

Interesting, I didn't realize that flexible-arrays.txt was still there;
that should go regardless (and 00-INDEX adjusted accordingly).  If you zap
the RST file, though, you should also fix Documentation/core-api/index.rst
or you'll break the docs build.

Thanks,

jon
