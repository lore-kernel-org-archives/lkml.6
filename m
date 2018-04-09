Return-Path: <kernel-hardening-return-12933-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49+Xf03FKYI7Ao/cQY1YCjsGW0rEjsZmBk1QKBwMFe2t7b/4KHy8T1SZKFXykAS5Z+hqP5x
ARC-Seal: i=1; a=rsa-sha256; t=1523300663; cv=none;
        d=google.com; s=arc-20160816;
        b=zuZhcNbiDVB+RXr2nDkJSmrhvKITw0mjHxdrgBFHwqbcoi6wNv2TrQ7/TVBHTWU7Xj
         kKh05uOJIjVzaypSiRO98MppuFJEOLJx297C+SA1NZHz8nwwlI+t+VNvCkeb/gllCG9p
         ZYajz8I0QI/yQcmeXmYaY6XgI2JtLYk3KHJaxlFyQK1Y4Usvrz9AsYuwYykoE/ZZPe1z
         rIky/DpK4i53q/AOKsvlkvku81vH2x5SYASw1NUJGgjse65lik3GqYuNZaz4y5aqDige
         BsQ8PRV/f59m1pdlcF7pr3BafABwsj8jMOka6uBEAlx3yw3hkJvJJYfpTsX+qQBjF2tj
         /AsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :delivered-to:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=C0OVMopkXV+y5UvXpRDcGPCjZ0qAfsu/anTlsNQW8cE=;
        b=Olygx0DfMwUlpg+M3RMMheMnQg4bi1AmNDfTZ8lDrI57uiyL8gZdeDgZO9vz9kQJFp
         vEEbx3ZfkISycjykRj7q02qRDYNi4Q/R/2/Np8b85Ca4r9aUP25tw/t1yOGSrqKKwLfu
         OHaZY3Jnc6Oyshph7CsrBQcUizALhck+2J3QqwJqk6f2T1JvcHUglPNm1utKIQCpCUxH
         1Jgr/DcYI3zsaZC8S2UCm09rxfHHvbhlbMnL+Iupa9iZcf7vvQtDXqg3+FwvYU66NMFg
         rUq4zKsEDa1JIOQpzY5vyXeirr0/DZKtpyx0D5fwbTWQJ+M3xBGW/DNrR50VG66299eS
         /9zQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@christofferdall-dk.20150623.gappssmtp.com header.s=20150623 header.b=1udonJSb;
       spf=pass (google.com: domain of kernel-hardening-return-12933-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12933-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@christofferdall-dk.20150623.gappssmtp.com header.s=20150623 header.b=1udonJSb;
       spf=pass (google.com: domain of kernel-hardening-return-12933-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12933-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Sender: Christoffer Dall <christofferdall@christofferdall.dk>
Date: Mon, 9 Apr 2018 21:03:24 +0200
From: Christoffer Dall <cdall@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
	catalin.marinas@arm.com, kvmarm@lists.cs.columbia.edu,
	linux-arch@vger.kernel.org, marc.zyngier@arm.com,
	suzuki.poulose@arm.com, will.deacon@arm.com, yao.qi@arm.com,
	kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
	awallis@codeaurora.org
Subject: Re: [PATCHv2 09/12] arm64/kvm: preserve host HCR_EL2 value
Message-ID: <20180409190324.GG10904@cbox>
References: <20171127163806.31435-1-mark.rutland@arm.com>
 <20171127163806.31435-10-mark.rutland@arm.com>
 <20180206123915.GA21802@cbox>
 <20180409145709.dneotb6xaznw44c4@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409145709.dneotb6xaznw44c4@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1585238090523877601?=
X-GMAIL-MSGID: =?utf-8?q?1597296516389439015?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 09, 2018 at 03:57:09PM +0100, Mark Rutland wrote:
> On Tue, Feb 06, 2018 at 01:39:15PM +0100, Christoffer Dall wrote:
> > On Mon, Nov 27, 2017 at 04:38:03PM +0000, Mark Rutland wrote:
> > > diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> > > index 525c01f48867..2205f0be3ced 100644
> > > --- a/arch/arm64/kvm/hyp/switch.c
> > > +++ b/arch/arm64/kvm/hyp/switch.c
> > > @@ -71,6 +71,8 @@ static void __hyp_text __activate_traps(struct kvm_vcpu *vcpu)
> > >  {
> > >  	u64 val;
> > >  
> > > +	vcpu->arch.host_hcr_el2 = read_sysreg(hcr_el2);
> > > +
> > 
> > Looking back at this, it seems excessive to switch this at every
> > round-trip.  I think it should be possible to have this as a single
> > global (or per-CPU) variable that gets restored directly when returning
> > from the VM.
> 
> I suspect this needs to be per-cpu, to account for heterogeneous
> systems.
> 
> I guess if we move hcr_el2 into kvm_cpu_context, that gives us a
> per-vcpu copy for guests, and a per-cpu copy for the host (in the global
> kvm_host_cpu_state).
> 
> I'll have a look at how gnarly that turns out. I'm not sure how we can
> initialise that sanely for the !VHE case to match whatever el2_setup
> did.

There's no harm in jumping down to EL2 to read a register during the
initialization phase.  All it requires is an annotation of the callee
function, and a kvm_call_hyp(), and it's actually quite fast unless you
start saving/restoring a bunch of additional system registers.  See how
we call __kvm_set_tpidr_el2() for example.

Thanks,
-Christoffer
