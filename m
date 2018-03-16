Return-Path: <richard.gong@linux.intel.com>
X-Google-Smtp-Source: AG47ELugtR81+yjg158kSgo5nu1gvrzjd6CovycJVwGsKlBQlq1p1Hfc+FMyxJfV2c8ZGF9NPAi/
ARC-Seal: i=1; a=rsa-sha256; t=1521221674; cv=none;
        d=google.com; s=arc-20160816;
        b=XfPQyE+CXxSKupXznyG6FAVnhzhSdmy2aeQ/a/2D4KKXC4+molmikjxZl9QSdS/laU
         7c8KBG73PGxz8Qm0uep72aRGg0HxVqrGdPJjpzpElTcM6LK/E0JPKfSYU2ZCkEWzQoCW
         zVULzyOO9sl5r/oHFtkdVcIQE9INNeshTk06Bhw/NfttCMHom4XVpVefLkdmWbNIfygO
         fqqwtJXfnlf5vOs9/LgpnGD/+S2yAY44uBQcpnzfxMdksHuuQAoj4bPwLuDPCF85/FxH
         T4urZH2fpFDH4MK4Gnnog6bO0JGSANOpU66wiMY9hMz1U214ylV66WNPc2UUtv8spLti
         w7Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:in-reply-to:mime-version:user-agent:date
         :message-id:references:cc:to:subject:from:arc-authentication-results;
        bh=jokfELG6G/i4uHxEAijoJZrL+oN9VxXJueHd7wmv1+4=;
        b=UcHUnR39THoa5QVkN8lws3WeCbibefhz14CsrffZl1AL6AOBALf0AjW6VGdQNx9zUF
         ATadpEQE2yVveEXWaffhHxsS0LEdQUuzhl//+OLunJ4Or7aAUIEr05wDcqogm6jlUuMz
         nHI+bjNvYxQQz6K4AGgRLkwVP8FCMR0BPIYZ89yrps0Cfl94Rb39/bqrnkN6cfNuKcZ+
         sktLG5cgnYST5Ur6TpqvQfyM81hK+D/r/zxqkTsDMEzDhV6Ib3RNX3JwgRGZ/fGz5IoT
         GnAZp1zF1pbehgeCrYP5mCLqmkM/TOwBMaEaMcAi4GwPHlUtqtLwnGrMY/A+A57n1EmC
         P4mQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of richard.gong@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=richard.gong@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of richard.gong@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=richard.gong@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,316,1517904000";
   d="scan'208,217";a="212266370"
From: Richard Gong <richard.gong@linux.intel.com>
Subject: Re: [PATCHv2 3/7] driver, misc: add Intel Stratix10 service layer
 driver
To: Greg KH <gregkh@linuxfoundation.org>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, dinguyen@kernel.org,
 robh+dt@kernel.org, mark.rutland@arm.com, atull@kernel.org, mdf@kernel.org,
 arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org, yves.vandervennet@linux.intel.com,
 Richard Gong <richard.gong@intel.com>
References: <1519949975-13548-1-git-send-email-richard.gong@linux.intel.com>
 <1519949975-13548-4-git-send-email-richard.gong@linux.intel.com>
 <20180315164836.GB4060@kroah.com>
Message-ID: <cf21af1f-e445-bd37-b5d6-f92c7aa00479@linux.intel.com>
Date: Fri, 16 Mar 2018 12:39:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315164836.GB4060@kroah.com>
Content-Type: multipart/alternative;
 boundary="------------771345B80174378AC29F04CD"
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593783309920179596?=
X-GMAIL-MSGID: =?utf-8?q?1595116538254144961?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a multi-part message in MIME format.
--------------771345B80174378AC29F04CD
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg,

Thanks for review.


On 03/15/2018 11:48 AM, Greg KH wrote:
> On Thu, Mar 01, 2018 at 06:19:31PM -0600,richard.gong@linux.intel.com  wrote:
>> +EXPORT_SYMBOL_GPL(request_svc_channel_byname);
> All of your global symbols should have the same prefix, not a verb.  So
> this should be:
> 	svc_channel_request_by_name(), right?
>
>> +EXPORT_SYMBOL_GPL(free_svc_channel);
> svc_channel_free()?
>
>> +EXPORT_SYMBOL_GPL(intel_svc_send);
> Wait, why doesn't the first ones have "intel_svc" in them?
>
> What is the difference here?
>
> Should they all just have "intel_svc_" as the prefix?
>
> Stick to one thing for all exported functions/variables please, it's the
> only way we can attempt to keep our namespace "sane".
Sure, I will make changes so that all exported functions will have 
"intel_svc_" as the prefix.
> Also, why would a 'misc' driver be exporting things that something else
> uses?  Why not just put this in the fpga directory next to the users of
> this code?
Intel Stratix10 service layer driver, running at privileged exception 
level (EL1), interfaces with
the service providers and providers the services for FPGA configuration, 
QSPI, Crypto, ECC,
and warm reset. Service layer driver also manages secure monitor call to 
communicate
with secure monitor code running at EL3.

FPGA manager is the first service provider. Later we will add several 
service providers, and extend
service layer driver to provide the services for QSPI, Crypto, ECC and 
warm reset.

Regards,
Richard
> thanks,
>
> greg k-h


--------------771345B80174378AC29F04CD
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Hi Greg,</p>
    <p>Thanks for review.<br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 03/15/2018 11:48 AM, Greg KH wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20180315164836.GB4060@kroah.com">
      <pre wrap="">On Thu, Mar 01, 2018 at 06:19:31PM -0600, <a class="moz-txt-link-abbreviated" href="mailto:richard.gong@linux.intel.com">richard.gong@linux.intel.com</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">+EXPORT_SYMBOL_GPL(request_svc_channel_byname);
</pre>
      </blockquote>
      <pre wrap="">All of your global symbols should have the same prefix, not a verb.  So
this should be:
	svc_channel_request_by_name(), right?

</pre>
      <blockquote type="cite">
        <pre wrap="">+EXPORT_SYMBOL_GPL(free_svc_channel);
</pre>
      </blockquote>
      <pre wrap="">svc_channel_free()?

</pre>
      <blockquote type="cite">
        <pre wrap="">+EXPORT_SYMBOL_GPL(intel_svc_send);
</pre>
      </blockquote>
      <pre wrap="">Wait, why doesn't the first ones have "intel_svc" in them?

What is the difference here?

Should they all just have "intel_svc_" as the prefix?

Stick to one thing for all exported functions/variables please, it's the
only way we can attempt to keep our namespace "sane".
</pre>
    </blockquote>
    Sure, I will make changes so that all exported functions will have
    "intel_svc_" as the prefix.<br>
    <blockquote type="cite" cite="mid:20180315164836.GB4060@kroah.com">
      <pre wrap="">Also, why would a 'misc' driver be exporting things that something else
uses?  Why not just put this in the fpga directory next to the users of
this code?
</pre>
    </blockquote>
    Intel Stratix10 service layer driver, running at privileged
    exception level (EL1), interfaces with<br>
    the service providers and providers the services for FPGA
    configuration, QSPI, Crypto, ECC,<br>
    and warm reset. Service layer driver also manages secure monitor
    call to communicate<br>
    with secure monitor code running at EL3. <br>
    <br>
    FPGA manager is the first service provider. Later we will add
    several service providers, and extend<br>
    service layer driver to provide the services for QSPI, Crypto, ECC
    and warm reset.<br>
    <br>
    Regards,<br>
    Richard <br>
    <blockquote type="cite" cite="mid:20180315164836.GB4060@kroah.com">
      <pre wrap="">thanks,

greg k-h
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------771345B80174378AC29F04CD--
