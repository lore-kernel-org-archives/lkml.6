Return-Path: <ben@transient.nz>
X-Google-Smtp-Source: AIpwx4/1lFKLHxq5Rp4afgwEo6L/07xkOUefvuOJucJeqL8hZhr2NSKFxcEsSff4PxP3/JEMZsnB
ARC-Seal: i=1; a=rsa-sha256; t=1523018866; cv=none;
        d=google.com; s=arc-20160816;
        b=yOUwUL9cwVYm+VFtgeL/q4hnB0w684ns1D5i4IvXuULIJomaz9By0N//manxWAxIOw
         +LcjwXystW4vLaY/pRSI0tcYuAIJJoG8O4wvKx5eYaCWEZKzWwAC+RPgUKJMybmglC5H
         SJMB2DVKTQc0V5a9GjO8sTPh6ljDQmgc4c8xe1KfsB5V/REUFgMfXZqHyA6C6P8VkZVH
         4d3+j4reJLFAvt5LkHaAZv5mbYnRMbhunTH2hOVSrrvp/hkV3qKCoiLFjAXdaylW1IYb
         XdDhWMu1GPq/bX8as3ryIyl727J6VeGRv62Mecl8B3cnWFOZiBZX+p4XW0PFjbkNf5HZ
         swJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=RehIDJZKkR4Uak+91/phv6RssdW2hiP2As/JdAlrJXg=;
        b=yVk2raL5Q/B5W33xhMLb04HY6MLZsCe2T9Tb7Zn8qd1S6MVAeTgzxm9Ix6JzuJ85nA
         UjgzAv70OcJqNCXQxyDrtThBKvP6sq0JORGSw6DZ2DGgOiLfycpl7KUIJv5B6C6RQNMZ
         IaXtyLDZbbtPzT6DD+iAogORozMurod1angrJymOtbmISHq7lyN3x6+6OteRabuEiz2b
         fNyi+6NBQJ658ivoVPVEUkY/JZLOF8/lCF+eDjqJd5X1S4wvl0aijmZA34hQBd/pSb71
         6x34zaI/0VPukmi4YIMN7Qo35hMKE+1vKrE/h3LsO9AN3dzUctsT8KJ9OmcpeeMk1nZl
         Yncw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=temperror (no key for signature) header.i=@transient.nz header.s=default header.b=AHCyNHVC;
       spf=neutral (google.com: 120.138.17.237 is neither permitted nor denied by best guess record for domain of ben@transient.nz) smtp.mailfrom=ben@transient.nz
Authentication-Results: mx.google.com;
       dkim=temperror (no key for signature) header.i=@transient.nz header.s=default header.b=AHCyNHVC;
       spf=neutral (google.com: 120.138.17.237 is neither permitted nor denied by best guess record for domain of ben@transient.nz) smtp.mailfrom=ben@transient.nz
Subject: Re: Commit *driver core: emit uevents when device is bound to a
 driver* causes regression
To: Paul Menzel <pmenzel+linux-input@molgen.mpg.de>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-input@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <8d22cfe6-90b6-eb86-d82e-0e037bfbed4e@molgen.mpg.de>
From: Ben Caradoc-Davies <ben@transient.nz>
Message-ID: <f097066f-8880-fb89-44ae-01ede7c0a06a@transient.nz>
Date: Sat, 7 Apr 2018 00:47:33 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <8d22cfe6-90b6-eb86-d82e-0e037bfbed4e@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-2.9
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - skyhawk.mysecure.co.nz
X-AntiAbuse: Original Domain - linuxfoundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - transient.nz
X-Get-Message-Sender-Via: skyhawk.mysecure.co.nz: authenticated_id: ben@transient.nz
X-Authenticated-Sender: skyhawk.mysecure.co.nz: ben@transient.nz
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596999326716133955?=
X-GMAIL-MSGID: =?utf-8?q?1597001029742673789?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Paul,

I agree that this is a regression in user space, but I would also like 
to note that, as I reported in Debian Bug#883425 ([3] and [4] below), I 
was able to restore user space functionality by upgrading to gvfs 
1.35.90-1. This later gvfs appears to support (i.e. survive) these uevents.

Kind regards,
Ben.

On 07/04/18 00:20, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Commit 1455cf8 (driver core: emit uevents when device is bound to a
> driver) [1], introduced in Linux 4.14-rc1, causes a regression in user 
> space.
> 
> After disconnecting USB devices, they are still shown as plugged in [2][3].
> 
>> I seem to be having a similar issue, but with an iPhone X using USB
>> to provide internet access. Even after the phone is disconnected, it
>> still shows up as "loaded active plugged". The only way to fix this
>> is to reboot or use a different USB port.
> 
> `git bisect` shows that commit 1455cf8 (driver core: emit uevents when 
> device is bound to a driver) is at fault [4].
> 
> As user space should not break with newer Linux kernels, do you know 
> what to do about that or can you think of a fix?
> 
> 
> Kind regards,
> 
> Paul
> 
> 
> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1455cf8dbfd06aa7651dcfccbadb7a093944ca65 
> 
> [2] https://github.com/systemd/systemd/issues/7587
> [3] https://bugs.debian.org/883425
> [4] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=883425#68
> 

-- 
Ben Caradoc-Davies <ben@transient.nz>
Director
Transient Software Limited <https://transient.nz/>
New Zealand
