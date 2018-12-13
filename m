Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51330C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010D920851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010D920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbeLMOWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:22:41 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34836 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727618AbeLMOWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:22:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7391F80D;
        Thu, 13 Dec 2018 06:22:39 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3980A3F59C;
        Thu, 13 Dec 2018 06:22:37 -0800 (PST)
Subject: Re: [PATCH v2 01/10] irqdomain: Add interface to request an irq
 domain
To:     Robert Richter <rrichter@cavium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "Richter, Robert" <Robert.Richter@cavium.com>,
        Julien Thierry <julien.thierry@arm.com>
References: <20181128144240.28727-1-rrichter@cavium.com>
 <20181128144240.28727-2-rrichter@cavium.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <1a98dc26-fc3f-988a-28b1-0452a465a364@arm.com>
Date:   Thu, 13 Dec 2018 14:22:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181128144240.28727-2-rrichter@cavium.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On 28/11/2018 14:43, Robert Richter wrote:
> This patch introduces a new interface to allow irq domain
> initialization regardless of order dependencies. This is done by
> requesting a domain and registering a callback function that is called
> as soon as a domain becomes available.
> 
> A typical irq domain initialization code is the following:
> 
> Parent initialization:
> 
> 	...
> 	domain = msi_create_irq_domain(fwnode, info, parent);
> 	if (domain)
> 		irq_domain_update_bus_token(domain, bus_token);
> 	...
> 
> Child initialization:
> 
> 	...
> 	parent = irq_find_matching_fwnode(fwnode, bus_token);
> 	if (!parent)
> 		...
> 	create_irq_domain(parent, ...);
> 	...
> 
> In case the parent is not yet available, the child initialization
> fails. Thus, the current implementation requires the parent domain
> being initialized before the child domain. With a complex irq domain
> hierarchy it becomes more and more difficult to grant that order as
> irq domains are enabled in separate subsystems. Care must be taken
> when initializing parent and child domains in the same initcall
> level. E.g. Arm's gic-v3-its implementation might have the following
> tree and dependencies:
> 
> 	gic-v3
> 	├── its-node-0
> 	│   ├── pci-host-0
> 	│   ├── platform-bus
> 	│   ...
> 	├── its-node-1
> 	│   ├── pci-host-1
> 	...
> 
> All domains must be initialized in top-down order of the tree.
> 
> This patch introduces an interface that allows domain initialization
> without any order requirements, e.g. to be able to initialize the irq
> domains in the same initcall level. The following functions have been
> introduced to allow the registration of a callback handler:
> 
> 	irq_domain_request_fwnode()
> 	irq_domain_request_host()
> 
> Instead of using the irq_find_matching_fwnode() function and it's
> variants the child code replaces them with the new functions and
> looks e.g. like the following:
> 
> 	...
> 	irq_domain_request_fwnode(fwnode, bus_token,
> 				create_irq_domain, name, priv);
> 	...
> 
> Here, the callback function create_irq_domain() is called as soon as
> the parent becomes available. All registered handlers are stored in a
> list. With each update of the bus token using irq_domain_update_bus_
> token(), the list is checked if that domain is requested by a handler
> and if that is the case it's callback function is called and the
> request removed from the list.
> 
> With a late_initcall all requests from the list should already have
> been handled, otherwise all remaining requests are removed with an
> error reported.
> 
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> ---
>  include/linux/irqdomain.h |  15 +++++
>  kernel/irq/irqdomain.c    | 163 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 178 insertions(+)
> 
> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
> index 068aa46f0d55..27e83803627d 100644
> --- a/include/linux/irqdomain.h
> +++ b/include/linux/irqdomain.h
> @@ -311,6 +311,21 @@ static inline struct irq_domain *irq_find_host(struct device_node *node)
>  	return d;
>  }
>  
> +typedef int (*irq_domain_callback_t)(struct irq_domain *, void *);
> +int irq_domain_request_fwnode(struct fwnode_handle *fwnode,
> +			enum irq_domain_bus_token bus_token,
> +			irq_domain_callback_t callback,
> +			const char *name, void *priv);
> +
> +static inline int irq_domain_request_host(struct device_node *node,
> +					enum irq_domain_bus_token bus_token,
> +					irq_domain_callback_t callback,
> +					void *priv)
> +{
> +	return irq_domain_request_fwnode(of_node_to_fwnode(node), bus_token,
> +					callback, node->full_name, priv);
> +}

I don't think you need this helper. There is no backward compat to
preserve in this case, and I believe all the potential users would be
using the fwnode variant.

I'm not keen at all on the name thing though. An OF node already has
one, and an irqchip fwnode caries one as part of the irqchip_fwid structure.

> +
>  /**
>   * irq_domain_add_linear() - Allocate and register a linear revmap irq_domain.
>   * @of_node: pointer to interrupt controller's device tree node.
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index 3366d11c3e02..ebe628dad568 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -21,6 +21,7 @@
>  #include <linux/fs.h>
>  
>  static LIST_HEAD(irq_domain_list);
> +static LIST_HEAD(irq_domain_requests);
>  static DEFINE_MUTEX(irq_domain_mutex);
>  
>  static struct irq_domain *irq_default_domain;
> @@ -45,6 +46,111 @@ static inline void debugfs_remove_domain_dir(struct irq_domain *d) { }
>  const struct fwnode_operations irqchip_fwnode_ops;
>  EXPORT_SYMBOL_GPL(irqchip_fwnode_ops);
>  
> +struct irq_domain_request {
> +	struct list_head		list;
> +	struct fwnode_handle		*fwnode;
> +	enum irq_domain_bus_token	bus_token;
> +	irq_domain_callback_t		callback;
> +	char				*name;
> +	void				*priv;
> +};
> +
> +static void irq_domain_call_handler(struct irq_domain *domain,
> +		irq_domain_callback_t callback, const char *name, void *priv)
> +{
> +	int ret;
> +
> +	ret = callback(domain, priv);
> +	if (ret)
> +		pr_err("%s: Domain request handler failed: %d\n",
> +			name, ret);
> +
> +	of_node_put(irq_domain_get_of_node(domain));
> +}
> +
> +static void irq_domain_free_request(struct irq_domain_request *request)
> +{
> +	kfree(request->name);
> +	kfree(request);
> +}
> +
> +static void irq_domain_handle_requests(struct fwnode_handle *fwnode,
> +                        enum irq_domain_bus_token bus_token)
> +{
> +	struct irq_domain *domain;
> +	struct irq_domain_request *request;
> +
> +	if (!fwnode)
> +		return;
> +redo:
> +	domain = irq_find_matching_fwnode(fwnode, bus_token);
> +	if (!domain)
> +		return;
> +
> +	mutex_lock(&irq_domain_mutex);
> +
> +	/*
> +	 * For serialization of irq domain updates make sure to handle
> +	 * (and remove) the request only if the domain still matches
> +	 * the request.
> +	 */
> +	if ((domain->fwnode != fwnode) || (domain->bus_token != bus_token)) {
> +		mutex_unlock(&irq_domain_mutex);
> +		goto redo;
> +	}
> +
> +	list_for_each_entry(request, &irq_domain_requests, list) {
> +		if (request->fwnode != fwnode ||
> +		    request->bus_token != bus_token)
> +			continue;
> +
> +		list_del(&request->list);
> +		mutex_unlock(&irq_domain_mutex);
> +
> +		irq_domain_call_handler(domain, request->callback,
> +					request->name, request->priv);
> +		irq_domain_free_request(request);
> +
> +		goto redo;
> +	}

This feels a bit convoluted. Pulling the various calls out of the loop
would be better.

> +
> +	mutex_unlock(&irq_domain_mutex);
> +}
> +
> +static int __init irq_domain_drain_requests(void)
> +{
> +	struct irq_domain_request *request;
> +	struct irq_domain *domain;
> +	int ret = 0;
> +redo:
> +	mutex_lock(&irq_domain_mutex);
> +
> +	list_for_each_entry(request, &irq_domain_requests, list) {
> +		list_del(&request->list);
> +		mutex_unlock(&irq_domain_mutex);
> +
> +		domain = irq_find_matching_fwnode(request->fwnode,
> +						request->bus_token);
> +		if (domain) {
> +			irq_domain_call_handler(domain, request->callback,
> +						request->name, request->priv);
> +		} else {
> +			ret = -ENODEV;
> +			pr_err("%s-%d: Unhandled domain request\n",
> +				request->name, request->bus_token);
> +		}
> +
> +		irq_domain_free_request(request);
> +
> +		goto redo;
> +	}

Why isn't this written in terms of irq_domain_handle_requests instead?

> +
> +	mutex_unlock(&irq_domain_mutex);
> +
> +	return ret;
> +}
> +late_initcall(irq_domain_drain_requests);

Why do you have to do all matching in this late initcall? I'd have hoped
for requests to be satisfied as domains get added, not as a last ditch
effort.

> +
>  /**
>   * irq_domain_alloc_fwnode - Allocate a fwnode_handle suitable for
>   *                           identifying an irq domain
> @@ -293,6 +399,8 @@ void irq_domain_update_bus_token(struct irq_domain *domain,
>  	debugfs_add_domain_dir(domain);
>  
>  	mutex_unlock(&irq_domain_mutex);
> +
> +	irq_domain_handle_requests(domain->fwnode, bus_token);
>  }
>  
>  /**
> @@ -417,6 +525,61 @@ struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
>  EXPORT_SYMBOL_GPL(irq_find_matching_fwspec);
>  
>  /**
> + * irq_domain_request_fwnode() - Requests a domain for a given fwspec
> + * @fwspec: FW specifier for an interrupt
> + * @bus_token: domain-specific data
> + * @callback: function to be called once domain becomes available
> + * @name: name to be used for fwnode
> + * @priv: private data to be passed to callback
> + *
> + * The callback function is called as soon as the domain is available.
> + */
> +int irq_domain_request_fwnode(struct fwnode_handle *fwnode,
> +			enum irq_domain_bus_token bus_token,
> +			irq_domain_callback_t callback,
> +			const char *name, void *priv)
> +{
> +	struct irq_domain *parent;
> +	struct irq_domain_request *request;
> +
> +	if (!fwnode || bus_token == DOMAIN_BUS_ANY || !callback || !name)

Why are you refusing DOMAIN_BUS_ANY? If that's what the caller wants, we
should satisfy it.

> +		return -EINVAL;
> +
> +	parent = irq_find_matching_fwnode(fwnode, bus_token);
> +	if (parent) {
> +		irq_domain_call_handler(parent, callback, name, priv);
> +		return 0;
> +	}
> +
> +	request = kzalloc(sizeof(*request), GFP_KERNEL);
> +	if (!request)
> +		return -ENOMEM;
> +
> +	request->fwnode = fwnode;
> +	request->bus_token = bus_token;
> +	request->callback = callback;
> +	request->name = kstrdup(name, GFP_KERNEL);
> +	request->priv = priv;
> +	INIT_LIST_HEAD(&request->list);
> +
> +	if (!request->name) {
> +		kfree(request);
> +		return -ENOMEM;
> +	}
> +
> +	of_node_get(to_of_node(fwnode));
> +
> +	mutex_lock(&irq_domain_mutex);
> +	list_add_tail(&request->list, &irq_domain_requests);
> +	mutex_unlock(&irq_domain_mutex);
> +
> +	/* recheck in case list changed */
> +	irq_domain_handle_requests(fwnode, bus_token);

Why do you need this? The whole thing is racy anyway, and you already
have a catch-all as a late initcall...

> +
> +	return 0;
> +}
> +
> +/**
>   * irq_domain_check_msi_remap - Check whether all MSI irq domains implement
>   * IRQ remapping
>   *
> 

Overall, this is a bit hackish. Why don't you resolve the deferred
requests as part of a domain being added instead? It would make things
much more straightforward.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
