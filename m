Return-Path: <rajatja@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1527031166; cv=none;
        d=google.com; s=arc-20160816;
        b=aUGykbkrAVwm9jKrZf44ZAGBjuZmzOoUK5/bZeH01QuD6gBmBfZpvFsmcUjHsMPeuC
         0Y9kzJS1gS/k3fxA2wlqVtHuuAic26AeBtK15nojygZfaY55M1x9FtUfgKFQUgsE8Awi
         7e4nOZew4aXMALu747h7+7v7JIdVJtDjGTa21dYHM/qQPMnVnWzTL51XNuKQPXwVOFrj
         F8k2rEmnCvi4RhR+4cQXYV0rrhI3Fszutkfkbbjhiuo7uQkVODEMOYIs5N0Jtu74JvZJ
         jVjwK5PeZqvPLKlcKrFYZFvVCFCMtsgSjollSmKe1aAtiyvdKHc+3Vw7E+kgELvUZK0Q
         QZWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=PSL3G1GIN3sf1jsXntaCTC2OY0wSHqzkBqBed/etgqE=;
        b=x5ITTtLeYUyFoLpUkiXFJdjts6WzBZNPeFArd+6PdQsCf+Ig/hos5HT2RVHmPK1edz
         0qJGUb+DXgeJPQls5BqVbotyWNN6ae+7/Oh5CvvvrTaHvlaFG/662G2s/ErMsuLZud0w
         +XJoHiM78ZGPE8F1YcqZmAS8XwPcgh1ul7KNxBcpx2LHacjNrX4K0Vew3pNoqSyRZ4iW
         1i+JkdN44a/d4EsAyAtJB16lTmr2phcVi24fSetldWG/7XREh9Ic7e1TpDPeB8+CMuBs
         OdnqojaofPlqzcSa8vDErqe/Yhv4mEqRl3BsQAo97eNmLKyT55DHaZBHTdtOg6+Y08nD
         141Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=dQLLiSoK;
       spf=pass (google.com: domain of rajatja@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rajatja@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=dQLLiSoK;
       spf=pass (google.com: domain of rajatja@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rajatja@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AB8JxZo3sg0krcN0WGS+B6Rv64gx3j2/rI+gDZXvUc2ibzx3qxdx/XT8m4lCBIqaNk/ld5t9BkfXYeSwxNUwv1uUXQw=
MIME-Version: 1.0
In-Reply-To: <cffe5b81-a05c-a249-8c36-70a9c4d61e7f@gmail.com>
References: <20180522222805.80314-1-rajatja@google.com> <20180522222805.80314-6-rajatja@google.com>
 <cffe5b81-a05c-a249-8c36-70a9c4d61e7f@gmail.com>
From: Rajat Jain <rajatja@google.com>
Date: Tue, 22 May 2018 16:18:45 -0700
Message-ID: <CACK8Z6E7Ax=_Ai7XOic5hWMRqQXiOox2z-w23j0S3O9P5AnCLw@mail.gmail.com>
Subject: Re: [PATCH 5/5] Documentation/PCI: Add details of PCI AER statistics
To: "Alex G." <mr.nuke.me@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Frederick Lawler <fred@fredlawl.com>, Oza Pawandeep <poza@codeaurora.org>,
	Keith Busch <keith.busch@intel.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Thomas Tai <thomas.tai@oracle.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
	linux-pci <linux-pci@vger.kernel.org>, linux-doc@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jes Sorensen <jsorensen@fb.com>,
	Kyle McMartin <jkkm@fb.com>, Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601205027389634414?=
X-GMAIL-MSGID: =?utf-8?q?1601208232246514768?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Tue, May 22, 2018 at 3:52 PM, Alex G. <mr.nuke.me@gmail.com> wrote:
> On 05/22/2018 05:28 PM, Rajat Jain wrote:
>> Add the PCI AER statistics details to
>> Documentation/PCI/pcieaer-howto.txt
>>
>> Signed-off-by: Rajat Jain <rajatja@google.com>
>> ---
>>  Documentation/PCI/pcieaer-howto.txt | 35 +++++++++++++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>>
>> diff --git a/Documentation/PCI/pcieaer-howto.txt b/Documentation/PCI/pcieaer-howto.txt
>> index acd0dddd6bb8..86ee9f9ff5e1 100644
>> --- a/Documentation/PCI/pcieaer-howto.txt
>> +++ b/Documentation/PCI/pcieaer-howto.txt
>> @@ -73,6 +73,41 @@ In the example, 'Requester ID' means the ID of the device who sends
>>  the error message to root port. Pls. refer to pci express specs for
>>  other fields.
>>
>> +2.4 AER statistics
>> +
>> +When AER messages are captured, the statistics are exposed via the following
>> +sysfs attributes under the "aer_stats" folder for the device:
>> +
>> +2.4.1 Device sysfs Attributes
>> +
>> +These attributes show up under all the devices that are AER capable. These
>> +indicate the errors "as seen by the device". Note that this may mean that if
>> +an end point is causing problems, the AER counters may increment at its link
>> +partner (e.g. root port) because the errors will be "seen" by the link partner
>> +and not the the problematic end point itself (which may report all counters
>> +as 0 as it never saw any problems).
>
> I was afraid of that. Is there a way to look at the requester ID to log
> AER errors to the correct device?

I do not think it is possible to pin point the source of the problem.
Errors may be caused due to sub optimal link tuning, or signal
integrity, or either of the link partners. Both the link partners will
detect and report the errors that they "see".

The bits and errors defined by the PCIe spec, follow the same semantics i.e.
 => the spec defines the different error conditions "as
seen/encountered by the device",
       => Thus the device reports those errors to the root port
               => which is what we are counting and reporting here.

IMHO, any interpretation / analysis of this error data / counters
should be left to the user so that he can look at different devices
and the errors they see, and then conclude on what might be the
problem.

Thanks,
Rajat

>
> Alex
