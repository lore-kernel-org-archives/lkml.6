Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AG47ELvofpUhNYWW1TD/BgIl4beXWrBYQiDqI+LlUu3FdeVOYIF3hsYmXaiP9phrKWBf23eIemAT
ARC-Seal: i=1; a=rsa-sha256; t=1521100444; cv=none;
        d=google.com; s=arc-20160816;
        b=CjXnMwE8bB0vW3ms/+cekSCO66iAjSlrQefubiakhqdqZDxXSw7DdbiBkVbZEU+SOr
         QEDDD7lHzwCSJYXbHtUqiYvf1Eahq/dakDIE2A80dw3T2rhwhfWQ62aPfD6m/UG6jWTG
         m4aPN4bKqeeQqOKR7+B9X/oxucEtoSUuqAfa6uFPg5anpqnJxDLGv22QedPxQ6AzIiwm
         kbA28Cq0sSaGLA75IdmpYKatdfEfD2fZb6XQsVVi617ZplCgKW8yMwtkwcwzZFgdiopL
         ZDxNtm1irr0kXJPMB48gmaHC2jfCKurLEkJDYZrBESzFRd+Hlh0dIK2bFGdEMzPWkXLp
         7OmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:references:in-reply-to:subject:cc:to:from
         :date:content-transfer-encoding:mime-version:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=auaqRHyW8V84yFlt+vQzPLXyUA/Ip5q4cOjSDhI+0rk=;
        b=cErS1veay5boiX2FPHvnWojqSc4qetJNr9tZDh05PC+R4/j8oxcAI3BJNebRsp92YJ
         Wsw+uiePM8m3kBUdAYrh1ZgrqtZhCNKqc5wa4faIA7hnY77v2gR8fx88MojkBKdKM3x0
         glhcSAQcLv6BN1655UmWcTb7GyFPPelmsDyHKw4cxVQehRV71sJB4dRNVw1QGPisk1R+
         puDrOeaZrbjjA0Zk5mexGq31uBfpury4OXzBbZAAOv39882l9LTMdyVNj25BRpDI1xdn
         FkDXW8t5Sas5/vLOODVGN93U12HxkHGmSBifetkYH1iG8o+NVgvy8L8lEBvOOcmgZZnC
         sfDg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=lu/va+sn;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=lu/va+sn;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=lu/va+sn;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=lu/va+sn;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 15 Mar 2018 13:24:03 +0530
From: poza@codeaurora.org
To: Keith Busch <keith.busch@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Wei
 Zhang <wzhang@fb.com>, Sinan Kaya <okaya@codeaurora.org>, Timur Tabi
 <timur@codeaurora.org>
Subject: Re: [PATCH v2] PCI/DPC: Fix PCI legacy interrupt acknowledgement
In-Reply-To: <20180314205230.GF29867@localhost.localdomain>
References: <1521042648-20522-1-git-send-email-poza@codeaurora.org>
 <20180314205230.GF29867@localhost.localdomain>
Message-ID: <b67f0624a9643f73a86126f4c6f18657@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594928862601446730?=
X-GMAIL-MSGID: =?utf-8?q?1594989419622887703?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-03-15 02:22, Keith Busch wrote:
> On Wed, Mar 14, 2018 at 09:20:48PM +0530, Oza Pawandeep wrote:
>> Current DPC driver acknowledges the interrupt in deferred work, which 
>> works
>> since MSI are edge triggered.
>> 
>> But when MSI is disabled (e.g. pci=nomsi boot option) port service
>> driver falls back to PCI legacy INT interrupt.
>> 
>> With current code we do not acknowledge the interrupt back in 
>> dpc_irq()
>> and we get dpc interrupt storm.
>> 
>> This patch acknowledges the interrupt in interrupt handler.
>> 
>> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
> 
> Thanks, this looks good to me.
> 
> Reviewed-by: Keith Busch <keith


checkpatch script shows
WARNING: 'acknowledgement' may be misspelled - perhaps 'acknowledgment'?

but dictionaries shows acknowledgement.

Regards,
Oza.
