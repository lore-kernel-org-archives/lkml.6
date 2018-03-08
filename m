Return-Path: <robh@kernel.org>
X-Google-Smtp-Source: AG47ELv7HlIqB9eGOQ0FzUqruZp8IUfmmhT1AKK7FHrDtc+LCJoLQ8q+obqlrHf+5bgWkRDA1+oZ
ARC-Seal: i=1; a=rsa-sha256; t=1520472314; cv=none;
        d=google.com; s=arc-20160816;
        b=cFAGGklfHpmVxqdba6MV2+Fs8hajmY5ni7oD9PjyC4wbrYlX89BDFHjYsSuwdLhmb7
         rQTA4iRmU4q1D+MbZMVIrDMprMH5mfiy54g7zNq/15sn4eCPr3dxSRpTP3Z2jSCA86XO
         DCDaCQhjxiLz/Oh7/R6lwZf81/9uPr+Rtozid9P8kCnDGVt5Lhq9QrkH4v0OR/2rcnvG
         LEY1ABjGd8bnpmCnICCLeWn2XpHFDNUdAAYHu3kziW6ILuqYd8oCQMBOIKEpr7XECvXx
         iT/beY0clrAiXM0H3M9FszIzziMGmfy4YP/nCohrh4R15mgW8Dx8we8tdUJIUr8p6K74
         H52Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=p3/vtctABeykhUBZMZ9BPobId7g9tEYS62QUTIH4kYI=;
        b=e57xD8J6YWaF31pAVJ3iAmOCJOqclsxTcSbk+nTSEMpwQUGCMujdutFqWRpFDSfr2i
         jgfJD9rVAVRhBYLd4OhSnzfmVidPlD5RyU5zsUmDmiM8n0XVsJ4k0sspoVw6oCacx/+4
         jfYo5txKD4SeCZP1mxnas4BqKwWnr2IfuufwWtkH7NJASejO5rRfNGy1OzdMIBqe43QT
         WYkXH1SKa96p9uRIx9YowJo1jp8h7am47FMSS4RtJMiQcm8TjkJ+o7iTuNufXH6uR8j3
         gY+rZIW8w80xaHOimbpXYfMIXUoBGFwn37IO54iqRpAnKyEKHsGouVfl1cRG9dWqlRIC
         78fg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9A621777
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
MIME-Version: 1.0
In-Reply-To: <CANk1AXS3gbLLy5fvyxcmeSBEaV2LZY9P=M3sOUHUceTgso5YkQ@mail.gmail.com>
References: <1519949975-13548-1-git-send-email-richard.gong@linux.intel.com>
 <1519949975-13548-5-git-send-email-richard.gong@linux.intel.com>
 <20180307194745.657ewa6rtcta6eqm@rob-hp-laptop> <CANk1AXS3gbLLy5fvyxcmeSBEaV2LZY9P=M3sOUHUceTgso5YkQ@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 7 Mar 2018 19:24:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLNxsVaMoefYfLi7ow8BjLkipNJwjvXgpEuXZZF8PT6+A@mail.gmail.com>
Message-ID: <CAL_JsqLNxsVaMoefYfLi7ow8BjLkipNJwjvXgpEuXZZF8PT6+A@mail.gmail.com>
Subject: Re: [PATCHv2 4/7] dt-bindings: fpga: add Stratix10 SoC FPGA manager binding
To: Alan Tull <atull@kernel.org>
Cc: Richard Gong <richard.gong@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, Dinh Nguyen <dinguyen@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Moritz Fischer <mdf@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-fpga@vger.kernel.org,
	Yves Vandervennet <yves.vandervennet@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593783311696826067?=
X-GMAIL-MSGID: =?utf-8?q?1594330778028400028?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 7, 2018 at 4:20 PM, Alan Tull <atull@kernel.org> wrote:
> On Wed, Mar 7, 2018 at 1:47 PM, Rob Herring <robh@kernel.org> wrote:
>> On Thu, Mar 01, 2018 at 06:19:32PM -0600, richard.gong@linux.intel.com wrote:
>>> From: Alan Tull <atull@kernel.org>
>>>
>>> Add a Device Tree binding for the Intel Stratix10 SoC FPGA manager.
>>>
>>> Signed-off-by: Alan Tull <atull@kernel.org>
>>> ---
>>> v2: this patch is added in patch set version 2
>>> ---
>>>  .../devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt  | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
>>> new file mode 100644
>>> index 0000000..78de689
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
>>> @@ -0,0 +1,10 @@
>>> +Intel Stratix10 SoC FPGA Manager
>>> +
>>> +Required properties:
>>> +- compatible : should contain "intel,stratix10-soc-fpga-mgr"
>>> +
>>> +Example:
>>> +
>>> +     fpga_mgr: fpga-mgr@0 {
>>> +             compatible = "intel,stratix10-soc-fpga-mgr";
>>
>> No reg or anything else? Is that because it all goes thru the service
>> layer firmware?
>
> Yes.
>
> There will be a few more clients of the service layer: QSPI, Crypto
> and warm reset.
>
>> Just get the service layer driver to instantiate a
>> device for this driver or get rid of the 2 layers if that's all the
>> firmware interface does. DT is not a Linux driver instantiation
>> mechanism.
>
> Right, this should be describing hardware.
>
> I could add this to the service layer binding:
>
> firmware {
>         svc {
>                 compatible = "intel,stratix10-svc";
>                 method = "smc";
>                 memory-region = <&service_reserved>;
>                 fpga-mgr {
>                         compatible = "intel,stratix10-soc-fpga-mgr";

Still, why do you need this node? If you don't have any other cross
tree connections, then the service layer can instantiate the
device(s).

OTOH, QSPI would need a node because you'll need to describe its bus.

Rob
