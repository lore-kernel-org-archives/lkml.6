Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECC6C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0EE20850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0EE20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754278AbeFRMrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:47:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:57028 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752856AbeFRMre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 08:47:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 05:47:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,239,1526367600"; 
   d="scan'208";a="47939394"
Received: from abyunus-mobl.amr.corp.intel.com (HELO [10.254.89.6]) ([10.254.89.6])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jun 2018 05:47:22 -0700
Subject: Re: [RFC PATCH] x86/arch_prctl: Add ARCH_SET_XCR0 to mask XCR0
 per-thread
To:     Keno Fischer <keno@juliacomputing.com>,
        linux-kernel@vger.kernel.org
References: <1529195582-64207-1-git-send-email-keno@alumni.harvard.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        Andi Kleen <andi@firstfloor.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Kyle Huey <khuey@kylehuey.com>,
        Robert O'Callahan <robert@ocallahan.org>
From:   Dave Hansen <dave.hansen@linux.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@linux.intel.com; keydata=
 xsFNBE6HMP0BEADIMA3XYkQfF3dwHlj58Yjsc4E5y5G67cfbt8dvaUq2fx1lR0K9h1bOI6fC
 oAiUXvGAOxPDsB/P6UEOISPpLl5IuYsSwAeZGkdQ5g6m1xq7AlDJQZddhr/1DC/nMVa/2BoY
 2UnKuZuSBu7lgOE193+7Uks3416N2hTkyKUSNkduyoZ9F5twiBhxPJwPtn/wnch6n5RsoXsb
 ygOEDxLEsSk/7eyFycjE+btUtAWZtx+HseyaGfqkZK0Z9bT1lsaHecmB203xShwCPT49Blxz
 VOab8668QpaEOdLGhtvrVYVK7x4skyT3nGWcgDCl5/Vp3TWA4K+IofwvXzX2ON/Mj7aQwf5W
 iC+3nWC7q0uxKwwsddJ0Nu+dpA/UORQWa1NiAftEoSpk5+nUUi0WE+5DRm0H+TXKBWMGNCFn
 c6+EKg5zQaa8KqymHcOrSXNPmzJuXvDQ8uj2J8XuzCZfK4uy1+YdIr0yyEMI7mdh4KX50LO1
 pmowEqDh7dLShTOif/7UtQYrzYq9cPnjU2ZW4qd5Qz2joSGTG9eCXLz5PRe5SqHxv6ljk8mb
 ApNuY7bOXO/A7T2j5RwXIlcmssqIjBcxsRRoIbpCwWWGjkYjzYCjgsNFL6rt4OL11OUF37wL
 QcTl7fbCGv53KfKPdYD5hcbguLKi/aCccJK18ZwNjFhqr4MliQARAQABzShEYXZpZCBDaHJp
 c3RvcGhlciBIYW5zZW4gPGRhdmVAc3I3MS5uZXQ+wsF7BBMBAgAlAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAUCTo3k0QIZAQAKCRBoNZUwcMmSsMO2D/421Xg8pimb9mPzM5N7khT0
 2MCnaGssU1T59YPE25kYdx2HntwdO0JA27Wn9xx5zYijOe6B21ufrvsyv42auCO85+oFJWfE
 K2R/IpLle09GDx5tcEmMAHX6KSxpHmGuJmUPibHVbfep2aCh9lKaDqQR07gXXWK5/yU1Dx0r
 VVFRaHTasp9fZ9AmY4K9/BSA3VkQ8v3OrxNty3OdsrmTTzO91YszpdbjjEFZK53zXy6tUD2d
 e1i0kBBS6NLAAsqEtneplz88T/v7MpLmpY30N9gQU3QyRC50jJ7LU9RazMjUQY1WohVsR56d
 ORqFxS8ChhyJs7BI34vQusYHDTp6PnZHUppb9WIzjeWlC7Jc8lSBDlEWodmqQQgp5+6AfhTD
 kDv1a+W5+ncq+Uo63WHRiCPuyt4di4/0zo28RVcjtzlGBZtmz2EIC3vUfmoZbO/Gn6EKbYAn
 rzz3iU/JWV8DwQ+sZSGu0HmvYMt6t5SmqWQo/hyHtA7uF5Wxtu1lCgolSQw4t49ZuOyOnQi5
 f8R3nE7lpVCSF1TT+h8kMvFPv3VG7KunyjHr3sEptYxQs4VRxqeirSuyBv1TyxT+LdTm6j4a
 mulOWf+YtFRAgIYyyN5YOepDEBv4LUM8Tz98lZiNMlFyRMNrsLV6Pv6SxhrMxbT6TNVS5D+6
 UorTLotDZKp5+M7BTQRUY85qARAAsgMW71BIXRgxjYNCYQ3Xs8k3TfAvQRbHccky50h99TUY
 sqdULbsb3KhmY29raw1bgmyM0a4DGS1YKN7qazCDsdQlxIJp9t2YYdBKXVRzPCCsfWe1dK/q
 66UVhRPP8EGZ4CmFYuPTxqGY+dGRInxCeap/xzbKdvmPm01Iw3YFjAE4PQ4hTMr/H76KoDbD
 cq62U50oKC83ca/PRRh2QqEqACvIH4BR7jueAZSPEDnzwxvVgzyeuhwqHY05QRK/wsKuhq7s
 UuYtmN92Fasbxbw2tbVLZfoidklikvZAmotg0dwcFTjSRGEg0Gr3p/xBzJWNavFZZ95Rj7Et
 db0lCt0HDSY5q4GMR+SrFbH+jzUY/ZqfGdZCBqo0cdPPp58krVgtIGR+ja2Mkva6ah94/oQN
 lnCOw3udS+Eb/aRcM6detZr7XOngvxsWolBrhwTQFT9D2NH6ryAuvKd6yyAFt3/e7r+HHtkU
 kOy27D7IpjngqP+b4EumELI/NxPgIqT69PQmo9IZaI/oRaKorYnDaZrMXViqDrFdD37XELwQ
 gmLoSm2VfbOYY7fap/AhPOgOYOSqg3/Nxcapv71yoBzRRxOc4FxmZ65mn+q3rEM27yRztBW9
 AnCKIc66T2i92HqXCw6AgoBJRjBkI3QnEkPgohQkZdAb8o9WGVKpfmZKbYBo4pEAEQEAAcLB
 XwQYAQIACQUCVGPOagIbDAAKCRBoNZUwcMmSsJeCEACCh7P/aaOLKWQxcnw47p4phIVR6pVL
 e4IEdR7Jf7ZL00s3vKSNT+nRqdl1ugJx9Ymsp8kXKMk9GSfmZpuMQB9c6io1qZc6nW/3TtvK
 pNGz7KPPtaDzvKA4S5tfrWPnDr7n15AU5vsIZvgMjU42gkbemkjJwP0B1RkifIK60yQqAAlT
 YZ14P0dIPdIPIlfEPiAWcg5BtLQU4Wg3cNQdpWrCJ1E3m/RIlXy/2Y3YOVVohfSy+4kvvYU3
 lXUdPb04UPw4VWwjcVZPg7cgR7Izion61bGHqVqURgSALt2yvHl7cr68NYoFkzbNsGsye9ft
 M9ozM23JSgMkRylPSXTeh5JIK9pz2+etco3AfLCKtaRVysjvpysukmWMTrx8QnI5Nn5MOlJj
 1Ov4/50JY9pXzgIDVSrgy6LYSMc4vKZ3QfCY7ipLRORyalFDF3j5AGCMRENJjHPD6O7bl3Xo
 4DzMID+8eucbXxKiNEbs21IqBZbbKdY1GkcEGTE7AnkA3Y6YB7I/j9mQ3hCgm5muJuhM/2Fr
 OPsw5tV/LmQ5GXH0JQ/TZXWygyRFyyI2FqNTx4WHqUn3yFj8rwTAU1tluRUYyeLy0ayUlKBH
 ybj0N71vWO936MqP6haFERzuPAIpxj2ezwu0xb1GjTk4ynna6h5GjnKgdfOWoRtoWndMZxbA
 z5cecg==
Message-ID: <d8503ac3-b6a4-d6cc-3db7-4e092724b79d@linux.intel.com>
Date:   Mon, 18 Jun 2018 05:47:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529195582-64207-1-git-send-email-keno@alumni.harvard.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/16/2018 05:33 PM, Keno Fischer wrote:
> For my use case, it would be sufficient to simply disallow
> any value of XCR0 with "holes" in it,
But what if the hardware you are migrating to/from *has* holes?

There's no way this is even close to viable until it has been made to
cope with holes.

FWIW, I just don't think this is going to be viable.  I have the feeling
that there's way too much stuff that hard-codes assumptions about XCR0
inside the kernel and out. This is just going to make it much more fragile.

Folks that want this level of container migration are probably better
off running one of the hardware-based containers and migrating _those_.
Or, just ensuring the places to/from they want to migrate have a
homogeneous XCR0 mix.

> @@ -252,6 +301,8 @@ void arch_setup_new_exec(void)
>  	/* If cpuid was previously disabled for this task, re-enable it. */
>  	if (test_thread_flag(TIF_NOCPUID))
>  		enable_cpuid();
> +	if (test_thread_flag(TIF_MASKXCR0))
> +		reset_xcr0_mask();
>  }

So the mask is cleared on exec().  Does that mean that *every*
individual process using this interface has to set up its own mask
before anything in the C library establishes its cached value of XCR0.
I'd want to see how that's being accomplished.

> +static int xstate_is_initial(unsigned long mask)
> +{
> +	int i, j;
> +	unsigned long max_bit = __ffs(mask);
> +
> +	for (i = 0; i < max_bit; ++i) {
> +		if (mask & (1 << i)) {
> +			char *xfeature_addr = (char *)get_xsave_addr(
> +					&current->thread.fpu.state.xsave,
> +					1 << i);
> +			unsigned long feature_size = xfeature_size(i);
> +
> +			for (j = 0; j < feature_size; ++j) {
> +				if (xfeature_addr[j] != 0)
> +					return 0;
> +			}
> +		}
> +	}
> +	return 1;
> +}

There is nothing architectural saying that the init state has to be 0.

> +	case ARCH_SET_XCR0: {

The interface is a mit burky.  The SET_XCR0 operation masks out the
"set" value from the current value?  That's a bit counterintuitive.

> +		unsigned long mask = xfeatures_mask & ~arg2;
> +
> +		if (!use_xsave())
> +			return -ENODEV;
> +
> +		if (arg2 & ~xfeatures_mask)
> +			return -ENODEV;

This is rather unfortunately comment-free.  "Are you trying to clear a
bit that was not set in the first place?"

Also, shouldn't this be dealing with the new task->xcr0, *not* the
global xfeatures_mask?  What if someone calls this more than once?

> +		if (!xcr0_is_legal(arg2))
> +			return -EINVAL;

FWIW, I don't really get the point of disallowing some of the values
made illegal in there.  Sure, you shoot yourself in the foot, but the
worst you'll probably see is a general-protection-fault from the XSETBV,
or from the first XRSTOR*.  We can cope with those, and I'd rather not
be trying to keep a list of things you're not allowed to do with XSAVE.

I also don't see any sign of checking for supervisor features anywhere.

> +		/*
> +		 * We require that any state components being disabled by
> +		 * this prctl be currently in their initial state.
> +		 */
> +		if (!xstate_is_initial(mask))
> +			return -EPERM;

Aside: I would *not* refer to the "initial state", for fear that we
could confuse it with the hardware-defined "init state".  From software,
we really have zero control over when the hardware is in its "init state".

But, in any case, so how is this supposed to work?

	// get features we are disabling into values matching the
	// hardware "init state".
	__asm__("XRSTOR %reg1,%reg2", ...);
	prctl(PRCTL_SET_XCR0, something);

?

That would be *really* fragile code from userspace.  Adding a printk()
between those two lines would probably break it, for instance.

I'd probably just not have these checks.
