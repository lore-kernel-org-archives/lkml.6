Return-Path: <chiu@endlessm.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521120489; cv=none;
        d=google.com; s=arc-20160816;
        b=QiJZuKLNFJ4H36nnq5X6L5YL4ba4hVf545GsTrxJvBtJKNyRsC6B27eL3gDZesy/aN
         VyTOGKDJKSXAoKxPu6lefev0aDcf7KVozmplRyeY4L7vvo/Nvb9+5i4GmO5UhqH97o44
         KsIKUepRZImpVj7cBw2j/6qttsrFSS83HY3OyBboWRLaI3yW4+9sDjsaXvaCiFiOmNOj
         1x4ZVfnSvwXQEy8LSi0bxRXFP2xK6gbmx/DWDBEwM0CGZVFJIbshPUhDA/7HVn8eSmfv
         dFTl9h/Q9TKovp+NI21/9D+3LEGFNyxphDXRcoBvWfmEce+ea8OOxXnMPfqeRtbe6mWh
         BvDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=NOiA2IRMusa669mftKTicxII6KFxlvjnMdmD8qfzyx8=;
        b=SfPbgNqnFOkKq0ohVj1FsLcjdkxtLZaWhXvqrIi8YDFhjL4BJzXwPUHe3/zZUVQ+Lv
         ZumBOhQegOE8m/j0GUZCx6QXVmN/FaODxOi2UIJ6yi12FjhdqX+mOFaBgoQ7Z18eZUpz
         XDMhE27XxhjfEK/ENHf9bURIcMfAW9WTCiMSJHAD+vfdV0lumryPyODMMphhrE4GdGFQ
         /w5AfYeWlLTR9E3OwZ/Xi5P93OWC0tANCCbbsvcWn16NDCodgI/HlrBQvC5m7ttxGF1E
         SgxugPduHpxyfFkE1jaau+cOru9aabBEnZ0nt9NdbKodbDMp2zM7KvMtDz5ioLT/d72G
         1MjA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@endlessm-com.20150623.gappssmtp.com header.s=20150623 header.b=cd/4nunS;
       spf=pass (google.com: domain of chiu@endlessm.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=chiu@endlessm.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@endlessm-com.20150623.gappssmtp.com header.s=20150623 header.b=cd/4nunS;
       spf=pass (google.com: domain of chiu@endlessm.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=chiu@endlessm.com
X-Google-Smtp-Source: AG47ELuTP4ZTRDWplOI4m3NOqztg6XY+WzpbCL7hPMuqPQn2afcczoMP7gKqP551OBlRgjVam6cM20PpsG8I0RM1p8A=
MIME-Version: 1.0
In-Reply-To: <6c8df688-b456-6f07-9325-6f4dfd8f0883@linux.intel.com>
References: <CAB4CAwf_k-WsF3zL4epm9TKAOu0h=Bv1XhXV_gY3bziOo_NPKA@mail.gmail.com>
 <6c8df688-b456-6f07-9325-6f4dfd8f0883@linux.intel.com>
From: Chris Chiu <chiu@endlessm.com>
Date: Thu, 15 Mar 2018 21:28:08 +0800
Message-ID: <CAB4CAwf39wW2LmuY-TZNdfgL=SBiDZuXvRNu7MD7j5Nc8O-bkg@mail.gmail.com>
Subject: Re: Intel GemniLake xHCI connected devices can never wake up the
 system from suspend
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594977262317953417?=
X-GMAIL-MSGID: =?utf-8?q?1595010437897695296?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 7:46 PM, Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
> On 15.03.2018 06:40, Chris Chiu wrote:
>>
>> Hi,
>>      I  have a ASUS AIO V222GA and another Acer Desktop XC-830 both
>> have Intel CPU J5005 and they both hit the same problem. The XHCI
>> connected USB keyboard/mouse can never wakeup the system from suspend.
>> It reminds me that similiar thing happens on ApolloLake too which
>> needs the XHCI_PME_STUCK_QUIRK to get it work. It's also mentioned in
>>
>> https://www.intel.com/content/dam/www/public/us/en/documents/specificati=
on-updates/pentium-celeron-n-series-spec-update.pdf
>> page #14 for N-seris intel CPU. And I also find the same problem
>> description in
>> https://www.intel.com/content/dam/www/public/us/en/documents/product-bri=
efs/silver-celeron-spec-update.pdf
>> page #16 for J-series Intel CPU. Seems that they have different
>> workaround so I can not simply apply XHCI_PME_STUCK_QUIRK to make it
>> work.
>>
>>      Anyone can help here?
>>
>
> N-Series
> CHP8: USB xHCI Controller May Not Re-Enter D3 State After a USB Wake Even=
t
> - needs XHCI_PME_STUCK_QUIRK in driver (sets bit 28 at offset 80a4)
>
> Intel=C2=AE Pentium=C2=AE Silver N5000
> Intel=C2=AE Pentium=C2=AE Silver J5005
> Intel=C2=AE Celeron=C2=AE N4000 and N4100
> Intel=C2=AE Celeron=C2=AE J4105 and J4005
>
> USB xHCI Controller May Not Re-enter a D3 State After a USB Wake Even
> Need to clear PME_EN bit of of the standard PCI PM_CSR register.
> I think Linux does this anyway (clears enabling PME when reaching D0)
> So if I remember correct there was no specific workaround needed for this=
.
>
> what is the PCI ID of your xhci controller? (lspci -nn)

They're both 8086:31a8. So you mean from the workaround description, it sho=
uld
work w/o any extra code? "Software should clear bit 8 (PME_EN) of PM_CSR" h=
as
been handled somewhere else?

>
> One other possible cause is that xHCI never reaches PCI device D3 suspend
> state during system suspend.
> xHC can't generate PME# wake event from normal running PCI device D0 stat=
e.
>
> PCI code in Linux will check with ACPI about the lowest possible D state
> when suspending,
> If there is something missing from the xHCI entry in ACPI DSDT table it
> might select D0.
> as the suspend state, causing wake failure.
>

Here's the DSDT ASL of the ASUS machine.
https://gist.github.com/mschiu77/8e9c8a0e5a98b70a6dfff45620340bf1

Don't know if the "lspci -vvv" output for the USB xHCI controller
provide any useful
information. There's "PME(D0-,D1-,D2-,D3hot+,D3cold+)" in the
following lspci log
https://gist.github.com/mschiu77/8cf523f0e564c1fca44398ebeb21b7bc


> Is there a BIOS update available for your ASUS and Acer?
>
> -Mathias

ASUS said the BIOS has no problem on USB wakeup under Windows so I don't th=
ink
there's any update. Anything else could be cause for this?
