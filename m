Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AG47ELtJ466q/fDbCJNvQRouMkOPKyt0K24xOMop8PV81BPa2lEI3wPGgthNg9hP9b27HLukB/F0
ARC-Seal: i=1; a=rsa-sha256; t=1521547736; cv=none;
        d=google.com; s=arc-20160816;
        b=bDFcvaNtj+PNhWps8oxn+2UHeIIAef3XNpUwva/tZTNis29GQc+HXT0AS/wVM5rtFP
         /Jx+a9BOukBRb0KOoP8Q+JmusDza9HnNqAmWJ768fG2qr45WJdq+MvXt3FCyccYrDKi4
         xk1QsUPVC5HSHoKdw7EHWiXD+jco3vjsr+IBJLJEGFYBChYghtZPp/0Ax3b1d2b0Iulx
         c6o6sJSDoZArRW+I7cnAjbXNfTEahTBl/QsNbjqs4LETI8rp8zGQWvl1ETsiEm0NnDyN
         mXkMY6ZHTZBQX5xCHYYz63tz2GOHQTFBrIT4UhrbVluZ9sLR3yZFZS51wqqLUuyLkfex
         rkgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=6BubXeVsFBTlvLeWc/tRAEcwyaNPAbr0OeVVo6/14jE=;
        b=bkQrq8K7rAvSy92GOrrQaP/DvgzCnZDvd9csmv2tCB506+rb0QS/SDNuwtAIFy6oPr
         gJxXSfzBxKb+3JqQv7mJ96IYIG4BzAVTxnvOyv5xCWT0/3f2O5ZB2ZdPzWWPOtbTGOqg
         WpsUfQD80gbmoumBVlY1BXA6KzoZB698E8pEZsf4jYWwCHt9birXU4aHNNeLkuJ57i16
         ZQ1pyfoZ0i8XWbnAjOELADQyAraUbjZGeK+NRuQ+e0qwg456XN7qtmMgmJI8tVhhUc0y
         ruGJlCBHbQJ+qeDGs4PJfMjROpJJ4TtbUQ/dv7l27JJIjA1S3S+rboZI8La5amFDceEt
         nZ9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Alexey Klimov <klimov.linux@gmail.com>, linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 16/20] clk: add support for clocks provided by SCMI
To: Stephen Boyd <sboyd@kernel.org>,
 ALKML <linux-arm-kernel@lists.infradead.org>,
 DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
 <1519403030-21189-17-git-send-email-sudeep.holla@arm.com>
 <152124137391.242365.17144416413429914606@swboyd.mtv.corp.google.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <6b5a56f7-ff0d-dde2-097b-bf245971e8a6@arm.com>
Date: Tue, 20 Mar 2018 12:08:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <152124137391.242365.17144416413429914606@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593209598817960240?=
X-GMAIL-MSGID: =?utf-8?q?1595458439487324573?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 16/03/18 23:02, Stephen Boyd wrote:
> Quoting Sudeep Holla (2018-02-23 08:23:46)
>> diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
>> new file mode 100644
>> index 000000000000..1e4d7a57779b
>> --- /dev/null
>> +++ b/drivers/clk/clk-scmi.c
>> +                       hws[idx] = &sclk->hw;
>> +               }
>> +       }
>> +
>> +       return of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
> 
> devm_of_clk_add_hw_provider?
> 

Thanks for noticing this, I wasn't aware of it's addition. This patch
predates that :(

>> +}
>> +
>> +static void scmi_clocks_remove(struct scmi_device *sdev)
>> +{
>> +       struct device *dev = &sdev->dev;
>> +       struct device_node *np = dev->of_node;
>> +
>> +       of_clk_del_provider(np);
>> +}
>> +
> 
> Drop?
> 

Sure, I will have to do these changes as add-on patch as this original
patch is already queued in ARM SoC tree for v4.17

> You can keep my acked-by otherwise.
> 

Thanks.

-- 
Regards,
Sudeep
