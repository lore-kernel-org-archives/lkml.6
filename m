Return-Path: <jani.nikula@intel.com>
X-Google-Smtp-Source: AH8x225Qa3e8AmqqFyR7ECZgkNrS8fXkE4gU+kt5WmkY6s33dBOTx5vTgffHpPkpKyzW1LG9IGG9
ARC-Seal: i=1; a=rsa-sha256; t=1517582288; cv=none;
        d=google.com; s=arc-20160816;
        b=PeoDrd5W9aj22djEGxqNErT366FcDsGHyflnlSwFUbRBK9LNGXTgCSJbasc3vAqxu/
         LuA9R6Ys126a9LmjyGvoq4RuRYpJh/tVi1QttJaxHyg33+nnQyxzFrWPshX8v1hi+GZs
         mZNDGO8BTdfuoBrcsA8gs17gsnWCArKRsg7qq3gsUXV/GHBPNb8gvNKLTOWsxeApeuQ5
         BBWsIWIq5SVjSDzKqao3RJK+sTLR1myJXp9XcoRXcEfKvgPYjOW42d/U6fL0FD4foI3y
         kKYGRjgLuGC7/ZFIquGxN4DSoqkX/YeWkYfXVigPxpI0DJGorzqWk2V3dcpCS3Lykqn/
         ExlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:references:organization:in-reply-to
         :subject:cc:to:from:arc-authentication-results;
        bh=pI4t1esEJvadRmmJgQilGSzQx28y+78e4TLv8ZmI2YQ=;
        b=DCgC0h2gxbNiX74J0+anVwwTHyMQm7mbY70cFw7uw87Mj6ymHJUp3w6S8eYKUyOraB
         IBrGhxGaXMz4FA85oQpFRzzluWzpB/hfLvFJt57HjyzqHufOTWvgQha1u1m8ElSJzOot
         2i6GQ0dPv3TvHWwIfO6lvFCTXoYgCsvEbGE37qIg0ufEGhwfCjNRfRbGsKk4syNaCMcS
         O/ZG7RD9a+qRF6ip9b7UZTq3VD2YCsO6N+pUt8CuHbxtGQ9dKptv8asXc/qJepA5TjnW
         TF/0NbPgIfUi9bxyULGn+T4chq7TZi3vYmTKaSPZsNRBbfW9JPo8whxE5fOFo55VxL+C
         QUqw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jani.nikula@intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=jani.nikula@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jani.nikula@intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=jani.nikula@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,448,1511856000";
   d="scan'208";a="27552163"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Knut Omang
 <knut.omang@oracle.com>, Ozan Alpay <ozyalpy@gmail.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Ville =?utf-8?B?U3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>, sil2review@lists.osadl.org,
 kernelnewbies@kernelnewbies.org, David Airlie <airlied@linux.ie>,
 intel-gfx@lists.freedesktop.org, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, llvmlinux@lists.linuxfoundation.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: clang warning: implicit conversion in intel_ddi.c:1481
In-Reply-To: <20180202131328.GA4456@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <alpine.DEB.2.20.1802011823340.4316@alpaca> <20180201180240.GA28042@kroah.com> <alpine.DEB.2.20.1802012045570.29994@hsp> <87372jkcu5.fsf@intel.com> <alpine.DEB.2.20.1802021054500.13838@hsp> <20180202100613.GA21492@kroah.com> <87h8qzisbt.fsf@intel.com> <20180202131328.GA4456@kroah.com>
Date: Fri, 02 Feb 2018 16:37:55 +0200
Message-ID: <871si3ihj0.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1591285684265715697?=
X-GMAIL-MSGID: =?utf-8?q?1591300365255234714?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 02 Feb 2018, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Fri, Feb 02, 2018 at 12:44:38PM +0200, Jani Nikula wrote:
>> 
>> +Knut, Fengguang
>> 
>> On Fri, 02 Feb 2018, Greg KH <gregkh@linuxfoundation.org> wrote:
>> > 	- If clang now builds the kernel "cleanly", yes, I want to take
>> > 	  warning fixes in the stable tree.  And even better yet, if you
>> > 	  keep working to ensure the tree is "clean", that would be
>> > 	  wonderful.
>> 
>> So we can run sparse using 'make C=1' and friends, or other static
>> analysis tools using 'make CHECK=foo C=1', as long as the passed command
>> line params work. There was work by Knut to extend this make checker
>> stuff [1]. Since mixing different HOSTCC's in a single workdir seems
>> like a bad idea, I wonder how hard it would be to make clang work like
>> this:
>> 
>> $ make CHECK=clang C=1
>> 
>> Or using Knut's wrapper. Feels like that could increase the use of clang
>> for static analysis of patches.
>
> Why not just build with clang itself:
> 	make CC=clang

Same as HOSTCC, mixing different CC's in a single build dir seems like a
bad idea. Sure, everyone can setup a separate build dir for clang, but
IMHO having 'make CHECK=clang C=1' work has least resistance. YMMV.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Technology Center
