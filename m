Return-Path: <vitezslav@samel.cz>
X-Google-Smtp-Source: AIpwx4/h1aqlCM+V5N9Je4fzmkbPeM5be4t64LXnBoMamXlqVWQru77oSubn2hNaZStWAsGAu0Yd
ARC-Seal: i=1; a=rsa-sha256; t=1524053321; cv=none;
        d=google.com; s=arc-20160816;
        b=ziIhnPSjB5arqToqk21LQCQZk/CLUrZ1GUOwKfEbHWIqbD6rbt5UCTMX8cuPEzW3Vu
         yNyk3Nk4qbiaEsai4WcEiLAzBkSXnIBI9Um0BROGgj2B13Jc7/rd7ungRALmtd9l9fbT
         O9w50/MkbqJmrXMKSSTomwaTP6XLGNDBrtmetui7209+nx28plPnv5VFlR189Toeo3VG
         3GwFCXPJdqq+GZbVcXIf0P8D2cL11fnhmrojRdna0IwEfQU51AB0XYj95Hj/pm31Zcjz
         KpJJFVcxnrhgn9eUjNUNpkyqM/14X0+mhg3MTNZnYns3THQj0UoquP9v40dki4IVCXLj
         uTKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=tEuV75JirpPjAdq6g61jZb2/IN4uFDH3ZQLdLSi+J0o=;
        b=E8g4J9yzRD7PmbeiR77mxNrYggunkAsUK2cl2PNg6sLK6rVV0pKV+6FjoKVfohxYXC
         Uxsj7T1WRO830VrpQVMSCi4x9FhCMBrm0TdXPA7THUIUI31VEzx4giYjPCm0jo3Zjswj
         YBCTbk1o3F0Ozrlg98rhLJ3segLko+K+3TXQbGJ2AODia0DowFRlP9mpA8GrogrksfGH
         8i7znWq5ND4j7tHgB51/AoArEXZuMoaW332rJAZCUf4QPebDysRF6rZRULZ9ZKdeUSzd
         6a6/aj80FJvBMnANOAqOuTYFnfww5bu9FeFVL1EAewIUbg57SefdU1u/Pu4MRQdvV5y2
         0mjg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 213.155.227.146 is neither permitted nor denied by best guess record for domain of vitezslav@samel.cz) smtp.mailfrom=vitezslav@samel.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 213.155.227.146 is neither permitted nor denied by best guess record for domain of vitezslav@samel.cz) smtp.mailfrom=vitezslav@samel.cz
Date: Wed, 18 Apr 2018 14:08:40 +0200
From: Vitezslav Samel <vitezslav@samel.cz>
To: Borislav Petkov <bp@suse.de>
Cc: Ashok Raj <ashok.raj@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: 4.15.17 regression: bisected: timeout during microcode update
Message-ID: <20180418120839.GA5655@pc11.op.pod.cz>
Mail-Followup-To: Borislav Petkov <bp@suse.de>,
	Ashok Raj <ashok.raj@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
References: <20180418081140.GA2439@pc11.op.pod.cz>
 <20180418100721.GA5866@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418100721.GA5866@pd.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598070825045426546?=
X-GMAIL-MSGID: =?utf-8?q?1598085735834046336?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 12:07:21PM +0200, Borislav Petkov wrote:
> On Wed, Apr 18, 2018 at 10:11:40AM +0200, Vitezslav Samel wrote:
> >   Could be done anything to prevent this panic?
> 
> Yes, for starters, is there anything preventing you from using an initrd
> and doing early microcode loading?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/x86/microcode.txt
> 
> If no, consider doing that and not using the late method which is
> problematic at best.

  I switched to firmware-in-kernel early loading and that works OK.
But still, the reported issue is regression in 4.15.17 and 4.16+.

	Thanks,

		Vita
