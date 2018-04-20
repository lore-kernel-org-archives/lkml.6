Return-Path: <vitezslav@samel.cz>
X-Google-Smtp-Source: AIpwx4/aiQzDcsfJ7+9UnXevztH1qSS2u2wn/H+BD3y+Ph5pE6GWs6nGLxXU1gyEA3CRKChyeWfY
ARC-Seal: i=1; a=rsa-sha256; t=1524218492; cv=none;
        d=google.com; s=arc-20160816;
        b=iCcxVs5CLFORkNXopw05viiJkfk4WGOXViPV92KMQGYIptOmJURbJ7p6heFM0p17Qz
         UDpWOY2GJJon76NvfqO41F/QnoxX6M3oFymSBpzZEXWCRunXlG8DBwm6zaVI5Wf4QuTq
         9t3ZGKx1xzCsmG/SvcIr7egQnBPW0We/PZJbzoZFW9K/7qw0D3Cfd578jvKUHyvTGu15
         5XLcZW73F9SIgz0mtAL5dx0YGsVvkbE7OkVccZB8ILVQ/gDzsxvDWf54N4nB7/w5J1NQ
         zDQQd4OReOxFlwk5tBFktlmj5Ey3NQ4G8MXsxQTZPDWx2rX4LhdWnmA6HHMw/07wB63j
         qdww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=5ufziXQauuIpXge9XQaRKRX0AwO5Qa5pWHYe02aPo+s=;
        b=tGGxPiLdoP2xlpDBhMsmaLOkfrPFQvzczK2kMNA0EeZcVjDeHZe2VHzYLE3RNEeij8
         gi8Ln8naZBtj71Ih9Y655EeWoaQAdTd1dpSkrcg8SWm9jw5iv0Y45BunQ60B7pGehtNg
         eSb0T45O4tvVb9Ky4q7qB3pb/VnOlCol6yVIEnblprg6bfdUKzW2Z+FA4qeryOvkbiZf
         FYY2fu2QLCKjgP0gnLmxgWSKWxdAT5cxH38O22MC0tqZh2RSinkISOw3TwfqXi8sQMxt
         djq9Tx1z0nxmbSYHvW5m7mrKTJ6kI3MQtepL7YBPqGEe1eTvV3mdqqxbKg5Lq32VsmZS
         ckaw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 213.155.227.146 is neither permitted nor denied by best guess record for domain of vitezslav@samel.cz) smtp.mailfrom=vitezslav@samel.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 213.155.227.146 is neither permitted nor denied by best guess record for domain of vitezslav@samel.cz) smtp.mailfrom=vitezslav@samel.cz
Date: Fri, 20 Apr 2018 12:01:31 +0200
From: Vitezslav Samel <vitezslav@samel.cz>
To: Borislav Petkov <bp@suse.de>
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: 4.15.17 regression: bisected: timeout during microcode update
Message-ID: <20180420100131.GA14217@pc11.op.pod.cz>
Mail-Followup-To: Borislav Petkov <bp@suse.de>,
	"Raj, Ashok" <ashok.raj@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
References: <20180418122212.GA4290@pd.tnic>
 <20180418135330.GA23580@araj-mobl1.jf.intel.com>
 <20180419053531.GA2224@pc11.op.pod.cz>
 <20180419104829.GE3896@pd.tnic>
 <20180419120239.GA2377@pc11.op.pod.cz>
 <20180419121840.GF3896@pd.tnic>
 <20180419134627.GA2387@pc11.op.pod.cz>
 <20180419163734.GB3905@pd.tnic>
 <20180420062021.GA2253@pc11.op.pod.cz>
 <20180420095220.GA13977@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420095220.GA13977@pd.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598070825045426546?=
X-GMAIL-MSGID: =?utf-8?q?1598258930244312103?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 11:52:20AM +0200, Borislav Petkov wrote:
> On Fri, Apr 20, 2018 at 08:20:21AM +0200, Vitezslav Samel wrote:
> >   ;-)  This time it works.
> 
> Good. :-)
> 
> > microcode: __reload_late: CPU1 waiting to exit
> > x86/CPU: CPU features have changed after loading microcode, but might not take effect.
> > x86/CPU: Please consider either early loading through initrd/built-in or a potential BIOS update.
> > ------------------------------------------------------
> 
> Ok, and after this happens
> 
> $ grep microcode /proc/cpuinfo | uniq
> 
> shows only 0x24, correct?

  Yes.

> > 	Thank you very much,
> 
> No, thank you for reporting and testing!
> 
> Ok, cleaned up patches with commit messages coming up.

  Good.

	Cheers,

		Vita
