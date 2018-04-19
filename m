Return-Path: <ashok.raj@intel.com>
X-Google-Smtp-Source: AIpwx48lk7OBW5WwempXzduQJy4O1NHmDLex6DdiceY75V6q+MvNPczR1qwPw3+laCGJGrymeBA7
ARC-Seal: i=1; a=rsa-sha256; t=1524141140; cv=none;
        d=google.com; s=arc-20160816;
        b=xxANVgz863mAqL1EzdQkV0PyLCK7hXllHLbQGvqeSFs2spk33OBicYA1QZri+viRJg
         S6H2F6lLeFHzdyP0bF6YxU6yZf6CYBHjGlBRzuQlyXPWI235vS1ZqLNl13eOjXfrPM5G
         +NnmlQP6uUgBXICGB/ppTLblqSHnNd4qvV+ZCJZbuWL3byD7eLA2XcxzQzEzp9anmfcb
         +bstRQnJykHYM/yCmuufiq0XDN+5IkBdtHW2tcZUKJNnK+K0aCbHXIxV25zjDFiLHEDv
         OvSJO5jXr4gTqR+QbYwJ6Ixg4WC/9H3k/3wXCTpKGxd7sNpVcemAUidE1VTP914aZiOm
         iPtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=KENZV2L16i/dWAPZsvVrKox053s2X7pWJGNdkQ1hS/Q=;
        b=Hi43Onqzs27Tmtu24mq6fD4ES+DAos7jEOb/9FTtNdFrf8rG/MsJ66ORlWXM1em2tw
         4X/fyNfrCQkSEeonlpfObPUuxmmX2NIPTxpseIsTBzwE4wb0rShC7qwmgDE3NVNUD/b5
         ZOeskHtEF2snKvqhl9Lcwb6ZbJ1fkIyEfhpVaebT897bY6ytuPAGxb4Z6o+5ykic2XVe
         MEUdDlUcf9Kr7KgvFZpl9KHmKo82sm6Vg9rFvKBCtl1b6N05O2jJhhY8DRPfFscjaYgJ
         sqc9TYoT8gN/PnWT0yXInu5HZGbIcMFKsikCftLjoIcK8gLyqZ8+PHmqKxTvwf3SfJor
         7S+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ashok.raj@intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=ashok.raj@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ashok.raj@intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=ashok.raj@intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,469,1517904000";
   d="scan'208";a="35465898"
Date: Thu, 19 Apr 2018 05:32:18 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Borislav Petkov <bp@suse.de>
Cc: Vitezslav Samel <vitezslav@samel.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>
Subject: Re: 4.15.17 regression: bisected: timeout during microcode update
Message-ID: <20180419123217.GA19746@araj-mobl1.jf.intel.com>
References: <20180418081140.GA2439@pc11.op.pod.cz>
 <20180418100721.GA5866@pd.tnic>
 <20180418120839.GA5655@pc11.op.pod.cz>
 <20180418122212.GA4290@pd.tnic>
 <20180418135330.GA23580@araj-mobl1.jf.intel.com>
 <20180419053531.GA2224@pc11.op.pod.cz>
 <20180419104829.GE3896@pd.tnic>
 <20180419120239.GA2377@pc11.op.pod.cz>
 <20180419121840.GF3896@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419121840.GF3896@pd.tnic>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598070825045426546?=
X-GMAIL-MSGID: =?utf-8?q?1598177820015399614?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Thanks.. also can you remove the ret below, and send the output
of /proc/cpuinfo before and after?

On Thu, Apr 19, 2018 at 02:18:41PM +0200, Borislav Petkov wrote:
>  	} else {
> +		pr_info("%s: CPU%d returning 0x%x\n", __func__, cpu, err);
>  		return ret;
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  	}
>  

This should not panic, but curious what the microcode versions reported...
