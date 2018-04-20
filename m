Return-Path: <matthias.bgg@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524217285; cv=none;
        d=google.com; s=arc-20160816;
        b=pAt3B+e9QX4M5NWOAWLsdVTcyk8X9hp9F3BgIzktGk75YwX+USrZWb8AgR+6IgKWDM
         d7OizSa1Pv1n8xZAjeJ6nYa1pdLglHGO+sFKakaryw+uA/vc2AHFwhiRgKj8TVLuGJWD
         2mAEySzMT1t6Rmaeev9sFwHDVGWFzmgEiSkdS6RkYORrqoUcr60aRv0FpFsTk+Lf0B9M
         y8paNXsXEqOU4F7sxsng5raAb6GiO19xCNTnMGNQACYGa99/HRE+wLpxt9/qFbOPBX5z
         ZuMcaJtaHHJWASEpe4va7FtyQsKIpCW0jutvT8X4Z5pvMlVQduGoABbtTFST7Gyr+iMA
         /3Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:autocrypt:openpgp:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=DvxS86HwYXrX3p63mQfOGNXNjYcAZLgf1CZyo2Qq2tc=;
        b=iucib40AHd/RpVwgRvKHxtqbo5XWMDoX/rw8T2QAnxKxFlMfqjb3oZmcElmsmX0fSb
         /hBX6if8RKFipkxcnzdeSSZLIY3kF+Tl2YCH7A+kq5WYzm6zYU6v6XfJGxgAaDT+caAq
         Tb0uC1EHefYAu1yOUUtmvwOGcrh8Wrk29FT5h/tIoGp4ZxD3adGvuVE1vXkKQ6c6YFjj
         z3McFZq+vOXNMT2RzltYPsUUaEqzSSZIFKjdDuCUDZFDiafzU+MMV8JQt/I+DdfhE8BM
         nsUS39yg6xfIBzTsvYKYqroCV69vhDk7HlnN2bWD7ziYTPAQDkJAk6K/vDWdCseaP3kG
         fTqg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=k3sg9PHg;
       spf=pass (google.com: domain of matthias.bgg@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=matthias.bgg@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=k3sg9PHg;
       spf=pass (google.com: domain of matthias.bgg@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=matthias.bgg@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48wUXTuhkWWYuoTTwX24LjdBd/Du2/VUA+HRjT6Q/DiGSjPca//duN9DGRQauC0catxyapQFQ==
Subject: Re: [PATCH 1/8] drm/mediatek: Use regmap for register access
To: Philipp Zabel <p.zabel@pengutronix.de>, ulrich.hecht+renesas@gmail.com,
 laurent.pinchart@ideasonboard.com, ck.hu@mediatek.com, airlied@linux.ie,
 robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
 sboyd@codeaurora.org, lee.jones@linaro.org
Cc: davem@davemloft.net, gregkh@linuxfoundation.org, mchehab@kernel.org,
 rdunlap@infradead.org, pi-cheng.chen@linaro.org, sean.wang@mediatek.com,
 linux-clk@vger.kernel.org, linux@armlinux.org.uk,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <mbrugger@suse.com>
References: <20171114214114.15793-1-mbrugger@suse.com>
 <20171114214114.15793-2-mbrugger@suse.com>
 <1511427282.7685.1.camel@pengutronix.de>
From: Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 xsFNBFP1zgUBEAC21D6hk7//0kOmsUrE3eZ55kjc9DmFPKIz6l4NggqwQjBNRHIMh04BbCMY
 fL3eT7ZsYV5nur7zctmJ+vbszoOASXUpfq8M+S5hU2w7sBaVk5rpH9yW8CUWz2+ZpQXPJcFa
 OhLZuSKB1F5JcvLbETRjNzNU7B3TdS2+zkgQQdEyt7Ij2HXGLJ2w+yG2GuR9/iyCJRf10Okq
 gTh//XESJZ8S6KlOWbLXRE+yfkKDXQx2Jr1XuVvM3zPqH5FMg8reRVFsQ+vI0b+OlyekT/Xe
 0Hwvqkev95GG6x7yseJwI+2ydDH6M5O7fPKFW5mzAdDE2g/K9B4e2tYK6/rA7Fq4cqiAw1+u
 EgO44+eFgv082xtBez5WNkGn18vtw0LW3ESmKh19u6kEGoi0WZwslCNaGFrS4M7OH+aOJeqK
 fx5dIv2CEbxc6xnHY7dwkcHikTA4QdbdFeUSuj4YhIZ+0QlDVtS1QEXyvZbZky7ur9rHkZvP
 ZqlUsLJ2nOqsmahMTIQ8Mgx9SLEShWqD4kOF4zNfPJsgEMB49KbS2o9jxbGB+JKupjNddfxZ
 HlH1KF8QwCMZEYaTNogrVazuEJzx6JdRpR3sFda/0x5qjTadwIW6Cl9tkqe2h391dOGX1eOA
 1ntn9O/39KqSrWNGvm+1raHK+Ev1yPtn0Wxn+0oy1tl67TxUjQARAQABzSRNYXR0aGlhcyBC
 cnVnZ2VyIDxtYnJ1Z2dlckBzdXNlLmNvbT7CwXgEEwECACIFAlV6iM0CGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAAAoJENkUC7JWEwLx6isQAIMGBgJnFWovDS7ClZtjz1LgoY8skcMU
 ghUZY4Z/rwwPqmMPbY8KYDdOFA+kMTEiAHOR+IyOVe2+HlMrXv/qYH4pRoxQKm8H9FbdZXgL
 bG8IPlBu80ZSOwWjVH+tG62KHW4RzssVrgXEFR1ZPTdbfN+9Gtf7kKxcGxWnurRJFzBEZi4s
 RfTSulQKqTxJ/sewOb/0kfGOJYPAt/QN5SUaWa6ILa5QFg8bLAj6bZ81CDStswDt/zJmAWp0
 08NOnhrZaTQdRU7mTMddUph5YVNXEXd3ThOl8PetTyoSCt04PPTDDmyeMgB5C3INLo1AXhEp
 NTdu+okvD56MqCxgMfexXiqYOkEWs/wv4LWC8V8EI3Z+DQ0YuoymI5MFPsW39aPmmBhSiacx
 diC+7cQVQRwBR6Oz/k9oLc+0/15mc+XlbvyYfscGWs6CEeidDQyNKE/yX75KjLUSvOXYV4d4
 UdaNrSoEcK/5XlW5IJNM9yae6ZOL8vZrs5u1+/w7pAlCDAAokz/As0vZ7xWiePrI+kTzuOt5
 psfJOdEoMKQWWFGd/9olX5ZAyh9iXk9TQprGUOaX6sFjDrsTRycmmD9i4PdQTawObEEiAfzx
 1m2MwiDs2nppsRr7qwAjyRhCq2TOAh0EDRNgYaSlbIXX/zp38FpK/9DMbtH14vVvG6FXog75
 HBoOzsFNBFP2CRIBEACnG1DjNQwLnXaRn6AKLJIVwgX+YB/v6Xjnrz1OfssjXGY9CsBgkOip
 BVdzKHe62C28G8MualD7UF8Q40NZzwpE/oBujflioHHe50CQtmCv9GYSDf5OKh/57U8nbNGH
 nOZ16LkxPxuITbNV30NhIkdnyW0RYgAsL2UCy/2hr7YvqdoL4oUXeLSbmbGSWAWhK2GzBSei
 eq9yWyNhqJU+hKV0Out4I/OZEJR3zOd//9ngHG2VPDdK6UXzB4osn4eWnDyXBvexSXrI9Lqk
 vpRXjmDJYx7rvttVS3Etg676SK/YH/6es1EOzsHfnL8ni3x20rRLcz/vG2Kc+JhGaycl2T6x
 0B7xOAaQRqigXnuTVpzNwmVRMFC+VgASDY0mepoqDdIInh8S5PysuPO5mYuSgc26aEf+YRvI
 pxrzYe8A27kL1yXJC6wl1T4w1FAtGY4B3/DEYsnTGYDJ7s7ONrzoAjNsSa42E0f3E2PBvBIk
 1l59XZKhlS/T5X0R8RXFPOtoE1RmJ+q/qF6ucxBcbGz6UGOfKXrbhTyedBacDw/AnaEjcN5C
 i7UfKksU95j0N9a/jFh2TJ460am554GWqG0yhnSQPDYLe/OPvudbAGCmCfVWl/iEb+xb8JFH
 q24hBZZO9QzcAJrWmASwG8gQGJW8/HIC0v4v4uHVKeLvDccGTUQm9QARAQABwsFfBBgBAgAJ
 BQJT9gkSAhsMAAoJENkUC7JWEwLxCd0QAK43Xqa+K+dbAsN3Km9yjk8XzD3Kt9kMpbiCB/1M
 VUH2yTMw0K5Bz61z5Az6eLZziQoh3PaOZyDpDK2CpW6bpXU6w2amMANpCRWnmMvS2aDr8oD1
 O+vTsq6/5Sji1KtL/h2MOMmdccSn+0H4XDsICs21S0uVzxK4AMKYwP6QE5VaS1nLOQGQN8Fe
 VNaXjpP/zb3WUSykNZ7lhbVkAf8d0JHWtA1laM0KkHYKJznwJgwPWtKicKdt9R7Jlg02E0dm
 iyXh2Xt/5qbztDbHekrQMtKglHFZvu9kHS6j0LMJKbcj75pijMXbnFChP7vMLHZxCLfePC+c
 kArWjhWU3HfpF+vHMGpzW5kbMkEJC7jxSOZRKxPBYLcekT8P2wz7EAKzzTeUVQhkLkfrYbTn
 1wI8BcqCwWk0wqYEBbB4GRUkCKyhB5fnQ4/7/XUCtXRy/585N8mPT8rAVclppiHctRA0gssE
 3GRKuEIuXx1SDnchsfHg18gCCrEtYZ9czwNjVoV1Tv2lpzTTk+6HEJaQpMnPeAKbOeehq3gY
 KcvmDL+bRCTjmXg8WrBZdUuj0BCDYqneaUgVnp+wQogA3mHGVs281v1XZmjlsVmM9Y8VPE61
 4zSiZQBL5CinBTTI8ssYlV/aIKYi0dxRcj6vYnAfUImOsdZ5AQja5xIqw1rwWWUOYb99
Message-ID: <3fffe06c-f19b-ef26-a19d-771611aae158@gmail.com>
Date: Fri, 20 Apr 2018 11:41:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1511427282.7685.1.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1584079267404697590?=
X-GMAIL-MSGID: =?utf-8?q?1598257664779563274?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Philipp,

On 11/23/2017 09:54 AM, Philipp Zabel wrote:
> Hi Matthias,
> 
> On Tue, 2017-11-14 at 22:41 +0100, Matthias Brugger wrote:
>> The mmsys memory space is shared between the drm and the
>> clk driver. Use regmap to access it.
>>
>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>> ---
>>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c |  4 ++--
>>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c  | 30 +++++++++++++++++-------------
>>  drivers/gpu/drm/mediatek/mtk_drm_ddp.h  |  4 ++--
>>  drivers/gpu/drm/mediatek/mtk_drm_drv.c  | 13 ++++---------
>>  drivers/gpu/drm/mediatek/mtk_drm_drv.h  |  2 +-
>>  5 files changed, 26 insertions(+), 27 deletions(-)
> [...]
[...]
>>  	}
>>  
>>  	value = mtk_ddp_sel_in(cur, next, &addr);
>>  	if (value) {
>> -		reg = readl_relaxed(config_regs + addr) & ~value;
>> -		writel_relaxed(reg, config_regs + addr);
>> +		regmap_read(config_regs, addr, &reg);
>> +		reg &= ~value;
>> +		regmap_write(config_regs, addr, reg);
> 
> 		regmap_update_bits(config_regs, addr, value, 0);
> 
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> 

Thanks for having a look on that.

I'll update the next version with regmap_update_bits and leave your Reviewed-by,
hope that's ok.

Regards,
Matthias
