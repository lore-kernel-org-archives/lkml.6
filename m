Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524913974; cv=none;
        d=google.com; s=arc-20160816;
        b=AE2vB1GiVvh0gHga7DSqkVmf/y5mh+wLMaNpfSajEbpsQueynzjBM+jtsEr/BGYeKs
         p//hTnrSK3SvLegRbG5pzqfTZvIiTviyyVLLVhhOhc0TRn/DBlp0Hfw1Ww4kPuG1ywtB
         cc/Rl07ca89zs3y4Iu6lMCMfDTXNz1N0by2w5MTLhDfvrf4gFyBGM9AMpH7ql0dkXkb3
         SnMwB9J5CdORMR7lGZ1L97zeNHn2WkAp7SyxKRXJG7i716HOsXb4uAPhGrOZp5vrh6yy
         fb3zNhs3kIQGvR330h28d0SZrFBJT05X6GfR20vMlGPapMqNCybdZnGFenC+Yv2dnsn2
         uzpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=oLMV9FII00kViZnxLUN/xqJfCDTUNXdSQ5gEauqXq+E=;
        b=JyoNE0ZM2mXIfnCTjbNOTKY100EdnsZpuJJsuOh9ZuG8onNW9lTzBWsqXI29moSqVS
         cNbkwIYxdda/WwCcVlB6IAxxf2LPC7AdCjZvdywC16SSRY6FNmRp8O6oake+0x1xOaxx
         +yE93Ql3BJiAOFKDSiyfUviS6Z/2hby3w9hQ0fkQ6xZXiCIDVKCoB0NuExQZ9kkV1Fpy
         NxGgJl7b+J09znLZfUwZRKPsx9ZmOasw/94jsKrCsubCBU1M4/mGyZivbTWIyCXvJ/fW
         fJjr5/ZdEKVQxivKzIb6jUhjY1433ErKq5+7kf4SppG2dakCXQxawTEBZEMFiJYMX0io
         uJ6g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=GSJ7Fr5Y;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=GSJ7Fr5Y;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZr/CCe1szAas2YzF7UpoXB4Upw4v2i77a7ur92c/qpGY7iDJH0VSHFp4hIusf01btToTo0Xaw==
Subject: Re: [PATCH v6 02/24] soc: qcom: Add APR bus driver
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org, bgoswami@codeaurora.org,
 gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
 <20180426094606.4775-3-srinivas.kandagatla@linaro.org>
 <20180428045155.GA491@tuxbook-pro>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <a5304418-1ce3-32b2-577d-0aab9160b7b0@linaro.org>
Date: Sat, 28 Apr 2018 12:12:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180428045155.GA491@tuxbook-pro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598801756443527719?=
X-GMAIL-MSGID: =?utf-8?q?1598988195243954926?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Thanks Bjorn for the review comments.

On 28/04/18 05:51, Bjorn Andersson wrote:
> On Thu 26 Apr 02:45 PDT 2018, Srinivas Kandagatla wrote:
>> diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
> [..]
>> +int apr_send_pkt(struct apr_device *adev, void *buf)
> 
> Sorry, but I think we have discussed this before?
> 
Yes, I did mention that I would give it a try and see, This change was 
pretty intrusive when I last looked at this.

I agree with you on asymmetry! I will change this and add struc apr_pkt 
which would apr_hdr followed by payload. This should also work for 
callback as well.

> "buf" isn't some random buffer to be sent, it is a apr_hdr followed by
> some data. As such I think you should make this type struct apr_hdr *,
> or if you think that doesn't imply there's payload make a type apr_pkt
> that has a payload[] at the end.
> 
> It will make it obvious for both future readers and the compiler what
> kind of data we're passing here.
> 
> 
> This comment also applies to functions calling functions that calls
> apr_send_pkt() as they too lug around a void *.
> 
>> +{
>> +	struct apr *apr = dev_get_drvdata(adev->dev.parent);
>> +	struct apr_hdr *hdr;
>> +	unsigned long flags;
>> +	int ret;
>> +
>> +	spin_lock_irqsave(&adev->lock, flags);
>> +
>> +	hdr = (struct apr_hdr *)buf;
>> +	hdr->src_domain = APR_DOMAIN_APPS;
>> +	hdr->src_svc = adev->svc_id;
>> +	hdr->dest_domain = adev->domain_id;
>> +	hdr->dest_svc = adev->svc_id;
>> +
>> +	ret = rpmsg_trysend(apr->ch, buf, hdr->pkt_size);
>> +	if (ret) {
>> +		dev_err(&adev->dev, "Unable to send APR pkt %d\n",
>> +			hdr->pkt_size);
> 
> Afaict all callers of this function will print an error message,
> sometimes on more than one level in the stack. And if some code path
> does retry sending you will get a printout for each attempt, even though
> the caller is fine with it.
> 
> I would recommend unlocking the spinlock and then do:

I can do that !!

> 
> 	return ret ? : hdr->pkt_size;
> 
>> +	} else {
>> +		ret = hdr->pkt_size;
>> +	}
>> +
>> +	spin_unlock_irqrestore(&adev->lock, flags);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(apr_send_pkt);
>> +

>> +
>> +static int apr_callback(struct rpmsg_device *rpdev, void *buf,
>> +				  int len, void *priv, u32 addr)
>> +{
>> +	struct apr *apr = dev_get_drvdata(&rpdev->dev);
>> +	struct apr_client_message data;
>> +	struct apr_device *p, *c_svc = NULL;
>> +	struct apr_driver *adrv = NULL;
>> +	struct apr_hdr *hdr;
>> +	unsigned long flags;
>> +	uint16_t hdr_size;
>> +	uint16_t msg_type;
>> +	uint16_t ver;
>> +	uint16_t svc;
>> +
>> +	if (len <= APR_HDR_SIZE) {
>> +		dev_err(apr->dev, "APR: Improper apr pkt received:%p %d\n",
>> +			buf, len);
>> +		return -EINVAL;
>> +	}
>> +
>> +	hdr = buf;
>> +	ver = APR_HDR_FIELD_VER(hdr->hdr_field);
>> +	if (ver > APR_PKT_VER + 1)
>> +		return -EINVAL;
>> +
>> +	hdr_size = APR_HDR_FIELD_SIZE_BYTES(hdr->hdr_field);
>> +	if (hdr_size < APR_HDR_SIZE) {
>> +		dev_err(apr->dev, "APR: Wrong hdr size:%d\n", hdr_size);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (hdr->pkt_size < APR_HDR_SIZE) {
> 
> I think it would be nice to make sure that hdr->pkt_size is < len as
> well, to reject messages that larger than the incoming buffer.
> 
> The pkt_size should be in the ballpark of len, could this check be
> changed to hdr->pkt_size != len?

Yep, It makes sense, I can add that check here.

> 
>> +		dev_err(apr->dev, "APR: Wrong paket size\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	msg_type = APR_HDR_FIELD_MT(hdr->hdr_field);
>> +	if (msg_type >= APR_MSG_TYPE_MAX && msg_type != APR_BASIC_RSP_RESULT) {
>> +		dev_err(apr->dev, "APR: Wrong message type: %d\n", msg_type);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (hdr->src_domain >= APR_DOMAIN_MAX ||
>> +			hdr->dest_domain >= APR_DOMAIN_MAX ||
>> +			hdr->src_svc >= APR_SVC_MAX ||
>> +			hdr->dest_svc >= APR_SVC_MAX) {
>> +		dev_err(apr->dev, "APR: Wrong APR header\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	svc = hdr->dest_svc;
>> +	spin_lock_irqsave(&apr->svcs_lock, flags);
>> +	list_for_each_entry(p, &apr->svcs, node) {
> 
> Rather than doing a O(n) search for the svc with svc_id you could use a
> idr or a radix_tree to keep the id -> svc mapping.

Am not 100% sure idr is correct thing here, as the svc_ids are static 
and the list we are talking here in worst case would be max of 13 
entires, in audio case it is just 4 services.
I think using radix_tree would be over do.

> 
>> +		if (svc == p->svc_id) {
>> +			c_svc = p;
>> +			if (c_svc->dev.driver)
>> +				adrv = to_apr_driver(c_svc->dev.driver);
>> +			break;
>> +		}
>> +	}
>> +	spin_unlock_irqrestore(&apr->svcs_lock, flags);
>> +
>> +	if (!adrv) {
>> +		dev_err(apr->dev, "APR: service is not registered\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	data.payload_size = hdr->pkt_size - hdr_size;
>> +	data.opcode = hdr->opcode;
>> +	data.src_port = hdr->src_port;
>> +	data.dest_port = hdr->dest_port;
>> +	data.token = hdr->token;
>> +	data.msg_type = msg_type;
>> +
>> +	if (data.payload_size > 0)
>> +		data.payload = buf + hdr_size;
>> +
> 
> Making a verbatim copy of parts of the hdr and then passing that to the
> APR devices creates an asymmetry in the send/callback API, without a
> whole lot of benefits. I would prefer that you introduce the apr_pkt, as
> described above, and once you have validated the size et al and found
> the service you just pass it along.
Okay, this would be a big rework, I will do it in next version.

> 
>> +	adrv->callback(c_svc, &data);
>> +
>> +	return 0;
>> +}
> [..]
>> +static int apr_uevent(struct device *dev, struct kobj_uevent_env *env)
>> +{
>> +	struct apr_device *adev = to_apr_device(dev);
>> +	int ret;
>> +
>> +	ret = of_device_uevent_modalias(dev, env);
>> +	if (ret != -ENODEV)
>> +		return ret;
>> +
>> +	return add_uevent_var(env, "MODALIAS= apr:%s", adev->name);
> 
> No space between '=' and "apr".
>
Yep.

>> +}
>> +
>> +struct bus_type aprbus = {
>> +	.name		= "aprbus",
> 
> Most busses doesn't have "bus" in the name.
> 
Yep, just "apr" make sense.

>> +	.match		= apr_device_match,
>> +	.probe		= apr_device_probe,
>> +	.uevent		= apr_uevent,
>> +	.remove		= apr_device_remove,
>> +};
>> +EXPORT_SYMBOL_GPL(aprbus);
>> +
>> +static int apr_add_device(struct device *dev, struct device_node *np,
>> +			  const struct apr_device_id *id)
>> +{
>> +	struct apr *apr = dev_get_drvdata(dev);
>> +	struct apr_device *adev = NULL;
>> +
>> +	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
>> +	if (!adev)
>> +		return -ENOMEM;
>> +
>> +	spin_lock_init(&adev->lock);
>> +
>> +	adev->svc_id = id->svc_id;
>> +	adev->domain_id = id->domain_id;
>> +	adev->version = id->svc_version;
>> +	if (np)
>> +		strncpy(adev->name, np->name, APR_NAME_SIZE);
>> +	else
>> +		strncpy(adev->name, id->name, APR_NAME_SIZE);
>> +
>> +	dev_set_name(&adev->dev, "aprsvc:%s:%x:%x", adev->name,
>> +		     id->domain_id, id->svc_id);
>> +
>> +	adev->dev.bus = &aprbus;
>> +	adev->dev.parent = dev;
>> +	adev->dev.of_node = np;
>> +	adev->dev.release = apr_dev_release;
>> +	adev->dev.driver = NULL;
>> +
>> +	spin_lock(&apr->svcs_lock);
>> +	list_add_tail(&adev->node, &apr->svcs);
>> +	spin_unlock(&apr->svcs_lock);
>> +
>> +	dev_info(dev, "Adding APR dev: %s\n", dev_name(&adev->dev));
>> +
>> +	return device_register(&adev->dev);
> 
> If this fails you must call put_device(&adev->dev);
> 
Agree!!
>> +}
>> +
>> +static void of_register_apr_devices(struct device *dev)
>> +{
>> +	struct apr *apr = dev_get_drvdata(dev);
>> +	struct device_node *node;
>> +
>> +	for_each_child_of_node(dev->of_node, node) {
>> +		struct apr_device_id id = { {0} };
>> +
>> +		if (of_property_read_u32(node, "reg", &id.svc_id))
>> +			continue;
>> +
>> +		id.domain_id = apr->dest_domain_id;
>> +
>> +		if (apr_add_device(dev, node, &id))
>> +			dev_err(dev, "Failed to add arp %d svc\n", id.svc_id);
>> +	}
>> +}
> [..]
>> +
>> +static int __init apr_init(void)
>> +{
>> +	int ret;
>> +
>> +	ret = bus_register(&aprbus);
>> +	if (!ret)
>> +		ret = register_rpmsg_driver(&apr_driver);
> 
> bus_unregister() if ret here.
> 
Yep.

Thanks,
srini
>> +
>> +	return ret;
>> +}
>> +
> 
> Regards,
> Bjorn
> 
