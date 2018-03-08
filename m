Return-Path: <robh@kernel.org>
X-Google-Smtp-Source: AG47ELtFf+XEYYXIt75xjOCp3rGQ0+En0ErvR39kfnYcsLHnjGjqVSbtHY9MgNCnve/32NYaffWa
ARC-Seal: i=1; a=rsa-sha256; t=1520548058; cv=none;
        d=google.com; s=arc-20160816;
        b=z4Gd47EfZWjT4wgCERvogWtSsP063VqEd8CB+jbbIoSXS3cP0ehfY4O0Y4Bl5xNHMn
         g4zQMKC+te7XiVVs74ocdjlKYrl2S1K/CY5/Cor1/mFd11z5c9NOUU/tCIYMEselMKZx
         QrKKur7qNw+JJ+vHcnNXqpEr8b6Hrv8weub1taL9ODiKqy/NTwp4XK0uWZPVJcKkOjJy
         z6yRRmw1Y+djfWiHNogvf1qODYFINss0AbRCj/5PRZ5NFdrFKD1yXyPmVUGTViT+zaMA
         moEv7EPL35C4Rm0TDCTPyAAlXYNV0AFyxikoYLluOqrykpEVjjOjvjc0Mmuxs/SkNQeU
         afSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=352CFyWaGY5UdbX1v0lzlTQIuPnb3TBnAjmjFNHwu54=;
        b=SQIwDCImStspYz2tdy6KW5IDfFNacQ42mDhqUdwDD5j7c7fW21YjE5AXiCKSW6TmNC
         3nPbqzze40NhS+vKRZBTkeJd/mWpVZY0IAaAMwDx5R5HNRKcFPbtea8d6eaT5iC/ylDF
         7LWXpY3qf5jNKIf+A5wkzhEKXmHcpb6xvr4ovf2EJWc7hLPJmHtPi6SviNZKxfTM89He
         3IGNDscdZxtFewm2K8fwBFAiQ0ub88opVAFW7k3be/6Pyk870AhKoN6OF59cNHfVMrGf
         9LzuG+5TjEIcdjjr/8tu1/+tVBjAfdADhBW3txS5lH725PDhIrNh9tfanbqGUjC/6Cm0
         twdQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9E682172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
MIME-Version: 1.0
In-Reply-To: <CANk1AXQRsAyFOGnUGcdWa0g0SdWu1PD=osYazj3nXJVq8ErABQ@mail.gmail.com>
References: <1519949975-13548-1-git-send-email-richard.gong@linux.intel.com>
 <1519949975-13548-5-git-send-email-richard.gong@linux.intel.com>
 <20180307194745.657ewa6rtcta6eqm@rob-hp-laptop> <CANk1AXS3gbLLy5fvyxcmeSBEaV2LZY9P=M3sOUHUceTgso5YkQ@mail.gmail.com>
 <CAL_JsqLNxsVaMoefYfLi7ow8BjLkipNJwjvXgpEuXZZF8PT6+A@mail.gmail.com> <CANk1AXQRsAyFOGnUGcdWa0g0SdWu1PD=osYazj3nXJVq8ErABQ@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 8 Mar 2018 16:27:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKNKZOCGhAJiuVMvYWK-27=AAo63xa5jF-gbezBky1tUQ@mail.gmail.com>
Message-ID: <CAL_JsqKNKZOCGhAJiuVMvYWK-27=AAo63xa5jF-gbezBky1tUQ@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1594410200791188588?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 8, 2018 at 9:32 AM, Alan Tull <atull@kernel.org> wrote:
> On Wed, Mar 7, 2018 at 7:24 PM, Rob Herring <robh@kernel.org> wrote:
>> On Wed, Mar 7, 2018 at 4:20 PM, Alan Tull <atull@kernel.org> wrote:
>>> On Wed, Mar 7, 2018 at 1:47 PM, Rob Herring <robh@kernel.org> wrote:
>>>> On Thu, Mar 01, 2018 at 06:19:32PM -0600, richard.gong@linux.intel.com wrote:
>>>>> From: Alan Tull <atull@kernel.org>
>>>>>
>>>>> Add a Device Tree binding for the Intel Stratix10 SoC FPGA manager.
>>>>>
>>>>> Signed-off-by: Alan Tull <atull@kernel.org>
>>>>> ---
>>>>> v2: this patch is added in patch set version 2
>>>>> ---
>>>>>  .../devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt  | 10 ++++++++++
>>>>>  1 file changed, 10 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
>>>>> new file mode 100644
>>>>> index 0000000..78de689
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
>>>>> @@ -0,0 +1,10 @@
>>>>> +Intel Stratix10 SoC FPGA Manager
>>>>> +
>>>>> +Required properties:
>>>>> +- compatible : should contain "intel,stratix10-soc-fpga-mgr"
>>>>> +
>>>>> +Example:
>>>>> +
>>>>> +     fpga_mgr: fpga-mgr@0 {
>>>>> +             compatible = "intel,stratix10-soc-fpga-mgr";
>>>>
>>>> No reg or anything else? Is that because it all goes thru the service
>>>> layer firmware?
>>>
>>> Yes.
>>>
>>> There will be a few more clients of the service layer: QSPI, Crypto
>>> and warm reset.
>>>
>>>> Just get the service layer driver to instantiate a
>>>> device for this driver or get rid of the 2 layers if that's all the
>>>> firmware interface does. DT is not a Linux driver instantiation
>>>> mechanism.
>>>
>>> Right, this should be describing hardware.
>>>
>>> I could add this to the service layer binding:
>>>
>>> firmware {
>>>         svc {
>>>                 compatible = "intel,stratix10-svc";
>>>                 method = "smc";
>>>                 memory-region = <&service_reserved>;
>>>                 fpga-mgr {
>
> Actually, add a label.
>
>                   fpga_mgr: fpga-mgr {
>
>>>                         compatible = "intel,stratix10-soc-fpga-mgr";
>>
>> Still, why do you need this node? If you don't have any other cross
>> tree connections, then the service layer can instantiate the
>> device(s).
>
> It's used for the FPGA region to know what mgr can program the region.

Ah yes, that's probably good enough reason.

Rob
