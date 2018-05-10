Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966522AbeEJQfA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 12:35:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34530 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965017AbeEJQe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 12:34:58 -0400
Date: Thu, 10 May 2018 09:34:56 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 1/2] scripts/kernel-doc: Auto-detect common
 code-blocks
Message-ID: <20180510163456.GC30442@bombadil.infradead.org>
References: <2ac6e3da22119f714406925139e40f4d835d11a4.1525962971.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ac6e3da22119f714406925139e40f4d835d11a4.1525962971.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 10:38:16AM -0400, Mauro Carvalho Chehab wrote:
> Comments that end with a comma and have certain keywords
> should be presented as code-blocks

I think this is a bit fragile.  Why not just search for ':\n'?  Is
there ever a case where we want to write:

/**
 * foo is a bar:
 * wibble
 */
and have wibble not be a code-block?
