Return-Path: <ashok.raj@intel.com>
X-Google-Smtp-Source: AIpwx48GrwB+d3B1osgc0/mal+ogJfs9L6PLEI84qyhbYEVRI5LSccY5YuE8qlxgd4Ck/+7v5nSX
ARC-Seal: i=1; a=rsa-sha256; t=1524239991; cv=none;
        d=google.com; s=arc-20160816;
        b=krrJm6ICF/OGXoy1YLxszP0pOhibSepuviGeR4msntDQL7mKKmKQDOouRpbGd4dsyZ
         J0UKkV/vs5akThO2lwZf4PvhXHsA1U38xBIveAdu7OMH0/Wy92u9bUvWqO/sIuIf+9IH
         Mcj4zLEgAKE3nFqxA6xPAGF42UM2wPO0mtVcOBVqDnezw+1fnE/AKE5cVKAbFLDrmUOE
         nrVVbC+6ckK1P3Zx5F98ZTJUysHlelPtAi5eUfkaknRg5JiM/2vdya5qYpUq07zOTw9z
         2QvC8zZ8ECViX/m48qsX80R7RbX2zLDvzh/yYaYycaCF3ZnYjaVMxicwO6ComJtuZPCM
         /exw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=rPkZXjfR3fTrDIxrgDb02K7zD9+clc2meJ3hlAIbuK0=;
        b=sx+z+HYVyOlHRk9J6L+FsdWu1Ypm9KGO2vVt4MyVQ3qG7zDY4B0S/9RCIHCyCw5X/6
         g6PAQn1l4i8S0tl3SiPuZPM8nLplBcZfRiU2NzaYPNPv6jpN85PPbjUjFyIg2hnS1OP0
         8L4PSRwKGECp/9vAzU/aPZEffPZeyEqheqPhafbeOdJHQ6nMNZygGUAU3YeFw7mEQ8Me
         QxJjkEfWnnGOflMUSTfQEOLF4OA1H4qms08GmP8Nl/HKh9MvEUb8GSGFMnQPUBjv1eEf
         LBJjaj2NCfb8CFavrMlF4fVrq/EHg8mAP0pLpwHL+BgkrO1rPyIYVAP6dElj74OCp+Vj
         HuGw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ashok.raj@intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=ashok.raj@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ashok.raj@intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=ashok.raj@intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,302,1520924400";
   d="scan'208";a="34902137"
Date: Fri, 20 Apr 2018 08:59:50 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Borislav Petkov <bp@suse.de>
Cc: Vitezslav Samel <vitezslav@samel.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, x86-ml <x86@kernel.org>
Subject: Re: [PATCH 1/2] x86/microcode/intel: Save microcode patch
 unconditionally
Message-ID: <20180420155950.GA9792@araj-mobl1.jf.intel.com>
References: <20180419104829.GE3896@pd.tnic>
 <20180419120239.GA2377@pc11.op.pod.cz>
 <20180419121840.GF3896@pd.tnic>
 <20180419134627.GA2387@pc11.op.pod.cz>
 <20180419163734.GB3905@pd.tnic>
 <20180420062021.GA2253@pc11.op.pod.cz>
 <20180420095220.GA13977@pd.tnic>
 <20180420100131.GA14217@pc11.op.pod.cz>
 <20180420103242.GB13977@pd.tnic>
 <20180420103428.GD13977@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420103428.GD13977@pd.tnic>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598261005085608238?=
X-GMAIL-MSGID: =?utf-8?q?1598281473300032412?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 12:34:28PM +0200, Borislav Petkov wrote:
> save_mc_for_early() was a no-op on !CONFIG_HOTPLUG_CPU but the
> generic_load_microcode() path saves the microcode patches it has found
> into our cache of patches which is used for late loading too. Regardless
> of whether we do CPU hotplug or not.
> 
> So make the saving unconditional so that late loading can find the
> proper patch.
> 
> Reported-by: Vitezslav Samel <vitezslav@samel.cz>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Ashok Raj <ashok.raj@intel.com>

Tested-by: Ashok Raj <ashok.raj@intel.com>

> Cc: <stable@vger.kernel.org> # if it has backported d8c3b52c00a05036e0a6b315b4b17921a7b67997
> Link: http://lkml.kernel.org/r/20180418081140.GA2439@pc11.op.pod.cz
> ---
