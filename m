Return-Path: <akpm@linux-foundation.org>
X-Google-Smtp-Source: AH8x225ZD6huZZP8TNjJAW7d5edb23wU1lPPO3tYUmf9XYW5Kp4MsN9AfxvjZJT8y2WtOLCxf5No
ARC-Seal: i=1; a=rsa-sha256; t=1518558843; cv=none;
        d=google.com; s=arc-20160816;
        b=w1Hsdkz3J+26aeizDsxEIlIoDV77Qze/SUAFKCymh/dDPgvzKWk26MQB659xwr51Mm
         QyfOY2kdYQJH+dZvcU4yCc3fOExjIjA+dPxWkQRKsex5cwj+yOauiFmeQQ9a++MDK1I3
         DxD3Vu+KhwQwV1rGfAtpyulgLBsOcOtg9qJ9mEt9Q3IyvCVDGmPhM8FZHkUmLEV8/R9Z
         Q8V/rSVzYG7VcbjiI2gdWZH4H86OX3WS9+ATS5gMGN65RDiDIzSi8+SuOkkjltmFTgfx
         cQDexh5w393xN9Q5uNpQCuu11LV7ECqAxPmdhjCWfrfh6+vrcaUF+Ei6JdzLLHOZrEXl
         gt4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Fqr6+fyxW+V1r0Hwa3xQD8S4zPkfUY4IvTkiA5C1tO0=;
        b=Ppx4lsNAgOBqpdtaMOnH770HItJQOVpoL59YmM5pT3WsfKClzBhtDoXwPBC6BXZtJI
         1AiMqEM+0ipE9HwBdDZ5IrWCAWuFy1Il4zFfmKcjy3V0g0JA+qovRTlb4HnATxVYuSiU
         lXAv7zG3XGlxZtNvtpaZl21ONPzfAhCKbi7lDyUIg/6lFGwU6RVJHQS8IyaAluUaCEDv
         nCogaqS6YTsuimitcXYVmzAwiUi+7Cj5O85PIqVCCguImW2kNgkyYxc4zjyX2XzI5j9P
         WqKbti8b2e5k3aBnLmXJ/E0ydxZfOJcnp8XPD+v0DDWY+sVepos+z6YInM+x3RvCoMcS
         i3nw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.92 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.92 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Date: Tue, 13 Feb 2018 13:53:59 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
 mgorman@techsingularity.net, mhocko@suse.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, vbabka@suse.cz,
 bharata@linux.vnet.ibm.com, tglx@linutronix.de, mingo@redhat.com,
 hpa@zytor.com, x86@kernel.org, dan.j.williams@intel.com,
 kirill.shutemov@linux.intel.com, bhe@redhat.com
Subject: Re: [PATCH v3 0/4] optimize memory hotplug
Message-Id: <20180213135359.705680d373a482b650f38b50@linux-foundation.org>
In-Reply-To: <20180213193159.14606-1-pasha.tatashin@oracle.com>
References: <20180213193159.14606-1-pasha.tatashin@oracle.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592315446760578462?=
X-GMAIL-MSGID: =?utf-8?q?1592324357272688035?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 13 Feb 2018 14:31:55 -0500 Pavel Tatashin <pasha.tatashin@oracle.com> wrote:

> This patchset:
> - Improves hotplug performance by eliminating a number of
> struct page traverses during memory hotplug.
> 
> - Fixes some issues with hotplugging, where boundaries
> were not properly checked. And on x86 block size was not properly aligned
> with end of memory
> 
> - Also, potentially improves boot performance by eliminating condition from
>   __init_single_page().
> 
> - Adds robustness by verifying that that struct pages are correctly
>   poisoned when flags are accessed.

I'm now attempting to get a 100% review rate on MM patches, which is
why I started adding my Reviewed-by: when I do that thing.

I'm not familiar enough with this code to add my own Reviewed-by:, and
we'll need to figure out what to do in such cases.  I shall be sending
out periodic review-status summaries.

If you're able to identify a suitable reviewer for this work and to
offer them beer, that would help.  Let's see what happens as the weeks
unfold.
