Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AH8x224r8VAoDC/B6D85InGGghibV+zrGjT2Dr2kWUrJjBhZIKW97dJ2gYLOCjMFswYXI5DTfacq
ARC-Seal: i=1; a=rsa-sha256; t=1519363476; cv=none;
        d=google.com; s=arc-20160816;
        b=I7Bqd/qPoiMTIIaPwepUzkgRS3oGhLkWMthS638mrs6f/+UdiSxp8uDb5OqDz8l2gC
         sYdUisPbfcs3VZjRK7ATH+38kvObhlso98XzH1VIvxv35b4kOtFXOrckEEHL3BiC5PYi
         xaprG5N6CB7/AnOrlpJDSzpDgzsmgmQZNMfxZUM+GYXz9R+JMva0TfW+EwbMwZjKC16Q
         HvQSMAOsdO2CVMESHqWB/vMnVb/0EFuB2+Rr54/VDYnPN/5VYq9qLBcsSDStJT1fUNx4
         VkH+yN/+OjfKBegCd7iGgNF4B261ZLo64+mNRjwuNIKYccOJKNP3QIGHNvBCL1aishPD
         HJJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:references:in-reply-to:subject:cc:to:from
         :date:content-transfer-encoding:mime-version:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=XqeJ0DCFA4LfXydSFk7Jf6Ju91ZvPAJXCC/Dh9YVed0=;
        b=Ip2VLoP3UqgJr0n9BfVZO1mNRlM+wURe7Dx8mYq7JZXwm150udXJsvur0eN77XnXuj
         tD6P6P1gefQnHKFMe/3uvkRedDZqjuZP8gl+JcyIIfgj6bkFepkZqA14U1d+cm3QPzNR
         By/vwcYcBr03YaZuj5voOzY7fB9RFQ/ewv5JWTJQiCzwwEBeH+hgHKF0CtJamBpFTsF5
         yrlYV+e82HCDuEDXxJkvel5lkrarJr5rLj3sgxR/PVGtR/UDVWLVzBGagH1M3Q1yEmfn
         6bnIPda1XNNQysd+U8f3YZFUFtLKOi+KGzG5xWztHBSLOGKrNhqYVYfrjw84T9drh9D0
         iG3A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Oa+xbnaq;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Fe8vpaap;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Oa+xbnaq;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Fe8vpaap;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 23 Feb 2018 10:54:35 +0530
From: poza@codeaurora.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Keith
 Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>, Sinan Kaya
 <okaya@codeaurora.org>, Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v10 1/7] PCI/AER: Rename error recovery to generic pci
 naming
In-Reply-To: <20180222183403.GA6267@infradead.org>
References: <1519315332-26852-1-git-send-email-poza@codeaurora.org>
 <1519315332-26852-2-git-send-email-poza@codeaurora.org>
 <20180222183403.GA6267@infradead.org>
Message-ID: <4388ff68e84185bd825abf7ff4ae952d@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593086403303503248?=
X-GMAIL-MSGID: =?utf-8?q?1593168076943584973?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-02-23 00:04, Christoph Hellwig wrote:
> On Thu, Feb 22, 2018 at 09:32:06PM +0530, Oza Pawandeep wrote:
>> This patch renames error recovery to generic name with pci prefix
>> 
>> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
>> 
>> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c 
>> b/drivers/pci/pcie/aer/aerdrv_core.c
>> index a4bfea5..306bf2f 100644
>> --- a/drivers/pci/pcie/aer/aerdrv_core.c
>> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
>> @@ -478,7 +478,7 @@ static pci_ers_result_t reset_link(struct pci_dev 
>> *dev)
>>  }
>> 
>>  /**
>> - * do_recovery - handle nonfatal/fatal error recovery process
>> + * pci_do_recovery - handle nonfatal/fatal error recovery process
>>   * @dev: pointer to a pci_dev data structure of agent detecting an 
>> error
>>   * @severity: error severity type
>>   *
>> @@ -486,7 +486,7 @@ static pci_ers_result_t reset_link(struct pci_dev 
>> *dev)
>>   * error detected message to all downstream drivers within a 
>> hierarchy in
>>   * question and return the returned code.
>>   */
>> -static void do_recovery(struct pci_dev *dev, int severity)
>> +static void pci_do_recovery(struct pci_dev *dev, int severity)
> 
> Maybe pcie_do_recovery?
> 

sure will take care.
Thanks.

> Otherwise looks fine:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
