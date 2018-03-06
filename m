Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520342363; cv=none;
        d=google.com; s=arc-20160816;
        b=hbYFYwDl/c11TQc55AkxhUIJaHki3PCG2f5FOiN00DrEEHdVKz3UjJCO12NdEzJ3ae
         PvybwBYa0ndGmxjSChs1W75JkitJpKwWwJ/eLh1UifCmbzXWhzGiFMMUTzForP3tmcep
         4fXlpuqUOanCeGcJE3/mFprB8T8aGFqX7UIePygNtksRGBmBVoDycQ3Hlc6R/kS9cO7T
         YHiG9a4GLD/ktyUul8vPSexPPWluFW8e+UEj99nhJeZ0tLNxte3UmYyqyzUFIM9cmxq/
         F8PxJwoYaSqmpHmS5m9rm4rj5rZNPO8ayeScwIwrwet5CC4neXdmJ3uaeU+Dnp9ercf+
         uPPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=X1GqLJSs70mU+Hi0nCNtIWkAnuFR5UYUEq2exZOJtPA=;
        b=wcF7kE0YPkeEcKhF5GiJ7aMfgzxFdnWOHtN1M7pNCHOyvI6UR7jdiezwDYVNRXlTZ+
         kkAD8LUIN3jlDayZufHTvdPWLpoTsRg9YyQkyguh0+tXYeabigkqRp4JAJ/cb2PSSUIx
         chb63N1l0GtY8w1JnCZk/cOhC422IGhUCZvFJvgTAj0gY3tp2k02QL18NmAtBJySw8CT
         MdHSriee3+xMLnb+M+9jEDmixOmAeUKRUYrAAS2nD+vZ/kLp0Tre3pfsLl89djfWISPu
         v7rjmrZDNABdviuGBhy04gQbXLLxB7KwbCXP8voavXuZhDus/Nw1blybfiroJKqvfTFf
         XQgA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rMZf7X2c;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rMZf7X2c;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AG47ELsf27hNfo36p0U4aS7dNaWzr9ZebAUD/lJS5I3YZJeOPCb6zk2KVAlNLA8n8bBIFlaxtxI5oTazWmGqLeBElwc=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180306130551.GA16061@amd>
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
 <20180221161606.32247-3-jae.hyun.yoo@linux.intel.com> <20180306124002.GA13950@amd>
 <20180306125416.GD26143@lunn.ch> <20180306130551.GA16061@amd>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 6 Mar 2018 14:19:22 +0100
X-Google-Sender-Auth: EEox9t7UDbbxxPcc3i00QRynH-U
Message-ID: <CAK8P3a2VvaFMO6jsx09ukN+=tj7sRZ9mkYGcSRiO1Fe6==sJ9A@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] [PATCH 2/8] Documentations: dt-bindings: Add a
 document of PECI adapter driver for Aspeed AST24xx/25xx SoCs
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Lunn <andrew@lunn.ch>, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, gregkh <gregkh@linuxfoundation.org>,
	Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, DTML <devicetree@vger.kernel.org>,
	linux-hwmon@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>,
	OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593027883264098537?=
X-GMAIL-MSGID: =?utf-8?q?1594194514707088400?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 6, 2018 at 2:05 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Tue 2018-03-06 13:54:16, Andrew Lunn wrote:
>> On Tue, Mar 06, 2018 at 01:40:02PM +0100, Pavel Machek wrote:
>> > Hi!
>> >
>> > > Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> > > ---
>> > >  .../devicetree/bindings/peci/peci-aspeed.txt       | 73 ++++++++++++++++++++++
>> > >  1 file changed, 73 insertions(+)
>> > >  create mode 100644 Documentation/devicetree/bindings/peci/peci-aspeed.txt
>> > >
>> > > diff --git a/Documentation/devicetree/bindings/peci/peci-aspeed.txt b/Documentation/devicetree/bindings/peci/peci-aspeed.txt
>> > > new file mode 100644
>> > > index 000000000000..8a86f346d550
>> > > --- /dev/null
>> > > +++ b/Documentation/devicetree/bindings/peci/peci-aspeed.txt
>> > > @@ -0,0 +1,73 @@
>> > > +Device tree configuration for PECI buses on the AST24XX and AST25XX SoCs.
>> >
>> > Are these SoCs x86-based?
>>
>> ARM, as far as i can tell. If i get the architecture correct, these
>> are BMC, Board Management Controllers, looking after the main x86 CPU,
>> stopping it overheating, controlling the power supplies, remote
>> management, etc.
>
> Ok, so with x86 machine, I get arm-based one for free. I get it. Is
> user able to run his own kernel on the arm system, or is it locked
> down, TiVo style?

In the past, they were all locked down, the team submitting those
patches in working on changing that. Have a look for OpenBMC.

       Arnd
