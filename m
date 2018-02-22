Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751582AbeBVVYo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 16:24:44 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44662 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751432AbeBVVYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 16:24:43 -0500
Date: Thu, 22 Feb 2018 13:24:41 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        linux-mm@kvack.org, kirill.shutemov@linux.intel.com, mhocko@suse.com,
        tglx@linutronix.de
Subject: Re: [PATCH v2 1/3] mm/sparse: Add a static variable
 nr_present_sections
Message-Id: <20180222132441.51a8eae9e9656a82a2161070@linux-foundation.org>
In-Reply-To: <20180222091130.32165-2-bhe@redhat.com>
References: <20180222091130.32165-1-bhe@redhat.com>
        <20180222091130.32165-2-bhe@redhat.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Feb 2018 17:11:28 +0800 Baoquan He <bhe@redhat.com> wrote:

> It's used to record how many memory sections are marked as present
> during system boot up, and will be used in the later patch.
> 
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -202,6 +202,7 @@ static inline int next_present_section_nr(int section_nr)
>  	      (section_nr <= __highest_present_section_nr));	\
>  	     section_nr = next_present_section_nr(section_nr))
>  
> +static int nr_present_sections;

I think this could be __initdata.

A nice comment explaining why it exists would be nice.
