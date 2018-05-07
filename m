Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752364AbeEGMbM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 08:31:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36573 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752341AbeEGMbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 08:31:09 -0400
X-Google-Smtp-Source: AB8JxZoRG+stxEvnhtm2z+AyDF3sqtMlVCEtOS5G0/TlGk2+ztQTbdk0YvkzwcAnqpggyB0mPCF+ww==
Date: Mon, 7 May 2018 14:31:04 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
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
        Jeff Layton <jlayton@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "Tobin C. Harding" <me@tobin.cc>, SeongJae Park <sj38.park@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Helmut Grohne <h.grohne@intenta.de>
Subject: Re: [PATCH 07/18] docs: core-api: add circular-buffers documentation
Message-ID: <20180507123104.GB5813@andrea>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
 <93ca8a46ed15b23d522ce514dbda62bd64d4584e.1525684985.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93ca8a46ed15b23d522ce514dbda62bd64d4584e.1525684985.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 06:35:43AM -0300, Mauro Carvalho Chehab wrote:
> The circular-buffers.txt is already in ReST format. So, move it to the
> core-api guide, where it belongs.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/00-INDEX                                          | 2 --
>  .../{circular-buffers.txt => core-api/circular-buffers.rst}     | 0
>  Documentation/core-api/index.rst                                | 1 +
>  Documentation/memory-barriers.txt                               | 2 +-
>  Documentation/translations/ko_KR/memory-barriers.txt            | 2 +-
>  5 files changed, 3 insertions(+), 4 deletions(-)
>  rename Documentation/{circular-buffers.txt => core-api/circular-buffers.rst} (100%)

Similarly:

./include/linux/circ_buf.h: * See Documentation/circular-buffers.txt for more information.
./drivers/lightnvm/pblk-rb.c: * (Documentation/circular-buffers.txt)
./drivers/media/dvb-core/dvb_ringbuffer.c:	 * for memory barriers also see Documentation/circular-buffers.txt

  Andrea


> 
> diff --git a/Documentation/00-INDEX b/Documentation/00-INDEX
> index c6b81ef9827b..a9dd1384d8e3 100644
> --- a/Documentation/00-INDEX
> +++ b/Documentation/00-INDEX
> @@ -80,8 +80,6 @@ cdrom/
>  	- directory with information on the CD-ROM drivers that Linux has.
>  cgroup-v1/
>  	- cgroups v1 features, including cpusets and memory controller.
> -circular-buffers.txt
> -	- how to make use of the existing circular buffer infrastructure
>  clk.txt
>  	- info on the common clock framework
>  cma/
> diff --git a/Documentation/circular-buffers.txt b/Documentation/core-api/circular-buffers.rst
> similarity index 100%
> rename from Documentation/circular-buffers.txt
> rename to Documentation/core-api/circular-buffers.rst
> diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
> index d4d71ee564ae..3864de589126 100644
> --- a/Documentation/core-api/index.rst
> +++ b/Documentation/core-api/index.rst
> @@ -26,6 +26,7 @@ Core utilities
>     genalloc
>     errseq
>     printk-formats
> +   circular-buffers
>  
>  Interfaces for kernel debugging
>  ===============================
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 983249906fc6..33b8bc9573f8 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -3083,7 +3083,7 @@ CIRCULAR BUFFERS
>  Memory barriers can be used to implement circular buffering without the need
>  of a lock to serialise the producer with the consumer.  See:
>  
> -	Documentation/circular-buffers.txt
> +	Documentation/core-api/circular-buffers.rst
>  
>  for details.
>  
> diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
> index 081937577c1a..2ec5fe0c9cf4 100644
> --- a/Documentation/translations/ko_KR/memory-barriers.txt
> +++ b/Documentation/translations/ko_KR/memory-barriers.txt
> @@ -3023,7 +3023,7 @@ smp_mb() 가 아니라 virt_mb() 를 사용해야 합니다.
>  동기화에 락을 사용하지 않고 구현하는데에 사용될 수 있습니다.  더 자세한 내용을
>  위해선 다음을 참고하세요:
>  
> -	Documentation/circular-buffers.txt
> +	Documentation/core-api/circular-buffers.rst
>  
>  
>  =========
> -- 
> 2.17.0
> 
