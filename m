Return-Path: <atull@kernel.org>
X-Google-Smtp-Source: AG47ELt6kVFO5CPlX3BbE1VKX7A4+Tsg+7CMrtsHzjLTcjeVO2U2ygPTA1afc6KBXQ408B/oqfr2
ARC-Seal: i=1; a=rsa-sha256; t=1520461283; cv=none;
        d=google.com; s=arc-20160816;
        b=EBZnrqmIGlRmzKuEEcLvIZweN7snImy5E7Rpeen+D+8xCpsbvw2Q8KkbYlJz2j7YGz
         Dk7uAZX1WhHUcEahNe6O/o3mHDDU2f9CtnbJRrlbqOhVIU3l8qj7cxF/XLr4mB/e5Gsh
         DGpvmfqdnjxLTyS5Gf/b6SPFc4v/lmYvhBF/lVvaiJZKAGPX9fwpcy6dEDkBJdwEznOt
         Zrh5snUYZG1Um98TrAx/Bnkwdenhp/raC7A1sE92jnwKZI71+LEk9ak8eDjIwz2NBqJ5
         sblkNGvqBq21GFCaIViU39YBNfVSh5P0AhXCjlvEUkQIoOpqW+z57tO97tRhplj325iI
         e3WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=M0RhvbsH9F8pSdIf27NuyDxBpCz8Y9CvSrUmz3KJiH0=;
        b=IBI+8rtJKhZh0epnuJ3osB3if31yfb+9oIFSHCzER6smR1++SmX8NaG68MoS0cxot/
         J48meestnP3aYX7kMrXwyWxg1WNgH6T71kM7noblJZDRYI55NEshxPqOWTyuQFsFATIi
         QiflSzKBxSsgAOg/uQnSn4EeFFl/5TBxGi3jX3Er7N3e4NMCgwWh/7NELG8eg3IF0f4W
         c7dVW+lqV8IL5fTYGCf0sXGRIJeutZQApPK0r/jsE6kuqt75Xp12o4VdHNnXWN5jZMHa
         /qV5g/xy+ygsrdvWDlCUPdWjXozVCjXIFu2crejsYS6wTg7PMvNEM0punbATN7QJdrBb
         YrpA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of atull@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=atull@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of atull@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=atull@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE5A21770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
MIME-Version: 1.0
In-Reply-To: <20180307194745.657ewa6rtcta6eqm@rob-hp-laptop>
References: <1519949975-13548-1-git-send-email-richard.gong@linux.intel.com>
 <1519949975-13548-5-git-send-email-richard.gong@linux.intel.com> <20180307194745.657ewa6rtcta6eqm@rob-hp-laptop>
From: Alan Tull <atull@kernel.org>
Date: Wed, 7 Mar 2018 16:20:41 -0600
X-Gmail-Original-Message-ID: <CANk1AXS3gbLLy5fvyxcmeSBEaV2LZY9P=M3sOUHUceTgso5YkQ@mail.gmail.com>
Message-ID: <CANk1AXS3gbLLy5fvyxcmeSBEaV2LZY9P=M3sOUHUceTgso5YkQ@mail.gmail.com>
Subject: Re: [PATCHv2 4/7] dt-bindings: fpga: add Stratix10 SoC FPGA manager binding
To: Rob Herring <robh@kernel.org>
Cc: Richard Gong <richard.gong@linux.intel.com>, catalin.marinas@arm.com,
	will.deacon@arm.com, Dinh Nguyen <dinguyen@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Moritz Fischer <mdf@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-fpga@vger.kernel.org,
	Yves Vandervennet <yves.vandervennet@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593783311696826067?=
X-GMAIL-MSGID: =?utf-8?q?1594319211085673904?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 7, 2018 at 1:47 PM, Rob Herring <robh@kernel.org> wrote:
> On Thu, Mar 01, 2018 at 06:19:32PM -0600, richard.gong@linux.intel.com wrote:
>> From: Alan Tull <atull@kernel.org>
>>
>> Add a Device Tree binding for the Intel Stratix10 SoC FPGA manager.
>>
>> Signed-off-by: Alan Tull <atull@kernel.org>
>> ---
>> v2: this patch is added in patch set version 2
>> ---
>>  .../devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt  | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
>>
>> diff --git a/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
>> new file mode 100644
>> index 0000000..78de689
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
>> @@ -0,0 +1,10 @@
>> +Intel Stratix10 SoC FPGA Manager
>> +
>> +Required properties:
>> +- compatible : should contain "intel,stratix10-soc-fpga-mgr"
>> +
>> +Example:
>> +
>> +     fpga_mgr: fpga-mgr@0 {
>> +             compatible = "intel,stratix10-soc-fpga-mgr";
>
> No reg or anything else? Is that because it all goes thru the service
> layer firmware?

Yes.

There will be a few more clients of the service layer: QSPI, Crypto
and warm reset.

> Just get the service layer driver to instantiate a
> device for this driver or get rid of the 2 layers if that's all the
> firmware interface does. DT is not a Linux driver instantiation
> mechanism.

Right, this should be describing hardware.

I could add this to the service layer binding:

firmware {
        svc {
                compatible = "intel,stratix10-svc";
                method = "smc";
                memory-region = <&service_reserved>;
                fpga-mgr {
                        compatible = "intel,stratix10-soc-fpga-mgr";
                };
        };
};

>
> And build your dts files with "W=1" because there's an error in this
> example.

Ouch.  Yes.

Warning (unit_address_vs_reg): Node /soc/fpga-mgr@0 has a unit name,
but no reg property

Thanks for the review,
Alan

>
> Rob
