Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966404AbeEJQvK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 12:51:10 -0400
Received: from ms.lwn.net ([45.79.88.28]:58112 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965017AbeEJQvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 12:51:08 -0400
Date: Thu, 10 May 2018 10:51:05 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 1/2] scripts/kernel-doc: Auto-detect common
 code-blocks
Message-ID: <20180510105105.5cb0d54f@lwn.net>
In-Reply-To: <20180510163456.GC30442@bombadil.infradead.org>
References: <2ac6e3da22119f714406925139e40f4d835d11a4.1525962971.git.mchehab+samsung@kernel.org>
        <20180510163456.GC30442@bombadil.infradead.org>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 May 2018 09:34:56 -0700
Matthew Wilcox <willy@infradead.org> wrote:

> I think this is a bit fragile.  Why not just search for ':\n'?  Is
> there ever a case where we want to write:
> 
> /**
>  * foo is a bar:
>  * wibble
>  */
> and have wibble not be a code-block?

Yeah, we might want to write something like:

 - Leading off a bulleted list

 1) or a numbered list

for example.  That's why I was thinking of looking for explicit markers
for such lists.

It'll take some playing around with to have a hope of getting right,
methinks.

jon
