Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G7VBPNIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DF80F607B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752097AbeFFO7s (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 10:59:48 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38314 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751986AbeFFO7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 10:59:45 -0400
X-Google-Smtp-Source: ADUXVKIHy0EOpzXX0/W5edIf/y1mYs+Blkj6W8exFMcoGp0xmvom6LBQmSEnJS1xriNzwnmX+2N2Dg==
From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v4 1/7] interconnect: Add generic on-chip interconnect API
To: Evan Green <evgreen@chromium.org>
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, robh+dt@kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        davidai@quicinc.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
 <20180309210958.16672-2-georgi.djakov@linaro.org>
 <CAE=gft76VpU1mXgNPK9-XTj6WoLHj-_SxAGuV-bUSNYVpfSn6w@mail.gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <43fedb5b-f4a5-8362-d0a2-534b85473bc1@linaro.org>
Date: Wed, 6 Jun 2018 17:59:42 +0300
MIME-Version: 1.0
In-Reply-To: <CAE=gft76VpU1mXgNPK9-XTj6WoLHj-_SxAGuV-bUSNYVpfSn6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

Thanks for the detailed review!

On 12.05.18 г. 0:30, Evan Green wrote:
> Hi Georgi,
> 
> On Fri, Mar 9, 2018 at 1:12 PM Georgi Djakov <georgi.djakov@linaro.org>
> wrote:
> 
>> This patch introduce a new API to get requirements and configure the
>> interconnect buses across the entire chipset to fit with the current
>> demand.
> 
>> The API is using a consumer/provider-based model, where the providers are
>> the interconnect buses and the consumers could be various drivers.
>> The consumers request interconnect resources (path) between endpoints and
>> set the desired constraints on this data flow path. The providers receive
>> requests from consumers and aggregate these requests for all master-slave
>> pairs on that path. Then the providers configure each participating in the
>> topology node according to the requested data flow path, physical links
> and
>> constraints. The topology could be complicated and multi-tiered and is SoC
>> specific.
> 
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>   Documentation/interconnect/interconnect.rst |  96 ++++++
>>   drivers/Kconfig                             |   2 +
>>   drivers/Makefile                            |   1 +
>>   drivers/interconnect/Kconfig                |  10 +
>>   drivers/interconnect/Makefile               |   1 +
>>   drivers/interconnect/core.c                 | 489
> ++++++++++++++++++++++++++++
>>   include/linux/interconnect-provider.h       | 109 +++++++
>>   include/linux/interconnect.h                |  40 +++
>>   8 files changed, 748 insertions(+)
>>   create mode 100644 Documentation/interconnect/interconnect.rst
>>   create mode 100644 drivers/interconnect/Kconfig
>>   create mode 100644 drivers/interconnect/Makefile
>>   create mode 100644 drivers/interconnect/core.c
>>   create mode 100644 include/linux/interconnect-provider.h
>>   create mode 100644 include/linux/interconnect.h
> 
> ...
>> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c

[..]

>> +static struct icc_path *path_allocate(struct icc_node *node, ssize_t
> num_nodes)
>> +{
> 
> So node is really the destination, correct? Then we use ->reverse to walk
> backwards num_nodes steps towards the source. It might increase readability
> to call the parameter dest, then assign that to a local called node for
> traversal.

Yes, exactly. Will change the name of the parameter to dst.

>> +       struct icc_path *path;
>> +       size_t i;
>> +
>> +       path = kzalloc(sizeof(*path) + num_nodes * sizeof(*path->reqs),
>> +                      GFP_KERNEL);
>> +       if (!path)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       path->num_nodes = num_nodes;
>> +
>> +       for (i = 0; i < num_nodes; i++) {
>> +               hlist_add_head(&path->reqs[i].req_node, &node->req_list);
>> +
>> +               path->reqs[i].node = node;
>> +               /* reference to previous node was saved during path
> traversal */
>> +               node = node->reverse;
>> +       }
>> +
>> +       return path;
>> +}
>> +
>> +static struct icc_path *path_find(struct icc_node *src, struct icc_node
> *dst)
>> +{
>> +       struct icc_node *node = NULL;
>> +       struct list_head traverse_list;
>> +       struct list_head edge_list;
>> +       struct list_head tmp_list;
>> +       size_t i, number = 0;
>> +       bool found = false;
>> +
>> +       INIT_LIST_HEAD(&traverse_list);
>> +       INIT_LIST_HEAD(&edge_list);
>> +       INIT_LIST_HEAD(&tmp_list);
> 
> tmp_list is really the list of nodes you've already visited and need to
> remember to reset is_traversed for. Maybe calling this done_list or
> visited_list would be more descriptive.

Yes, visited_list sounds better. Will change it.

>> +
>> +       list_add_tail(&src->search_list, &traverse_list);
> 
> For added paranoia, you could set src->reverse to NULL so that somebody
> elsewhere who had a bug in their back-traversal would fall off the end,
> rather than into some previous scrapped path.

Ok.

>> +
>> +       do {
>> +               list_for_each_entry(node, &traverse_list, search_list) {
>> +                       if (node == dst) {
>> +                               found = true;
>> +                               list_add(&node->search_list, &tmp_list);
>> +                               break;
>> +                       }
>> +                       for (i = 0; i < node->num_links; i++) {
>> +                               struct icc_node *tmp = node->links[i];
>> +
>> +                               if (!tmp)
>> +                                       return ERR_PTR(-ENOENT);
> 
> You just bail out here, but never clean up the nodes is_traversed, which
> will ruin later searches. Maybe a goto towards the common cleanup path?

Agree. Good catch.

>> +
>> +                               if (tmp->is_traversed)
>> +                                       continue;
>> +
>> +                               tmp->is_traversed = true;
>> +                               tmp->reverse = node;
>> +                               list_add_tail(&tmp->search_list,
> &edge_list);
>> +                       }
>> +               }
>> +               if (found)
>> +                       break;
>> +
>> +               list_splice_init(&traverse_list, &tmp_list);
>> +               list_splice_init(&edge_list, &traverse_list);
>> +
>> +               /* count the number of nodes */
>> +               number++;
> 
> Depth might be a better name for this, since this really counts the hops
> away from the source, rather than the number of nodes you've processed.

Ok, will change it to depth.

>> +
>> +       } while (!list_empty(&traverse_list));
>> +
>> +       /* reset the traversed state */
>> +       list_for_each_entry(node, &tmp_list, search_list)
>> +               node->is_traversed = false;
>> +
>> +       if (found)
>> +               return path_allocate(dst, number);
>> +
>> +       return ERR_PTR(-EPROBE_DEFER);
>> +}
>> +
>> +static int path_init(struct icc_path *path)
>> +{
>> +       struct icc_node *node;
>> +       size_t i;
>> +
>> +       for (i = 0; i < path->num_nodes; i++) {
>> +               node = path->reqs[i].node;
>> +
>> +               mutex_lock(&node->provider->lock);
>> +               node->provider->users++;
>> +               mutex_unlock(&node->provider->lock);
>> +       }
>> +
>> +       return 0;
>> +}
> 
> This function cannot fail, nor do you check its return value, so you should
> change the return type to void.

Ok.

> 
> I'm wondering if the locking here is a little sketchy. I was in the process
> of typing a suggestion that you call path_init from within path_find, since
> it seemed weird to have this gray zone of a path without its reference
> counts, when I noticed the locks.
> 
> I can't evaluate fully, since the implementation seems to be missing
> icc_node_remove, a critical function in terms of evaluating the locks. You
> have an icc_del_provider, but its warning of if (provider->users) is pretty
> weak, since without node removal provider->users could easily be
> incremented after the provider lock is released. It also leaks all of its
> nodes, since there's no way to remove them.
> 
> Here's my suggestion as far as the locking goes:
> * To add or remove links/nodes from the graph, you're going to need to hold
> a global lock to avoid colliding with traversals. You've already got an
> icc_path_mutex, so that would work.
> * icc_link_create needs to hold the global icc_path_mutex, since it's
> messing with arrays and connections used in path traversal, and doesn't
> need to hold the provider lock, since it's not changing anything there.
> * The presumably upcoming icc_link_destroy, or its parent icc_node_destroy,
> also needs to hold the global lock. node_destroy may also need the provider
> lock in symmetry with icc_node_add.
> * Provider->users will be protected under the global icc_path_mutex, rather
> than the provider lock. Then move path_init into path_find, or inline it
> into path_allocate.
> * Once you do that, provider->lock is now only protecting its node list.
> For now, it's probably more efficient to roll the protection of
> provider->nodes under the global lock as well, and remove the lock from the
> provider altogether. If you anticipate other functions in the future that
> will require a lock in the provider, then it might make sense to keep the
> lock, or maybe just add it later with that new functionality.

Ok, i will try to simplify this. Using one global lock would be ok for
now. Will implement the complete set for functions for remove links and
nodes from the topology.

>> +
>> +static void node_aggregate(struct icc_node *node)
>> +{
>> +       struct icc_req *r;
>> +       u32 agg_avg = 0;
>> +       u32 agg_peak = 0;
>> +
>> +       hlist_for_each_entry(r, &node->req_list, req_node) {
>> +               /* sum(averages) and max(peaks) */
>> +               agg_avg += r->avg_bw;
>> +               agg_peak = max(agg_peak, r->peak_bw);
>> +       }
>> +
>> +       node->avg_bw = agg_avg;
>> +       node->peak_bw = agg_peak;
>> +}
>> +
>> +static void provider_aggregate(struct icc_provider *provider, u32
> *avg_bw,
>> +                              u32 *peak_bw)
>> +{
>> +       struct icc_node *n;
>> +       u32 agg_avg = 0;
>> +       u32 agg_peak = 0;
>> +
>> +       /* aggregate for the interconnect provider */
>> +       list_for_each_entry(n, &provider->nodes, node_list) {
>> +               /* sum the average and max the peak */
>> +               agg_avg += n->avg_bw;
>> +               agg_peak = max(agg_peak, n->peak_bw);
>> +       }
>> +
>> +       *avg_bw = agg_avg;
>> +       *peak_bw = agg_peak;
>> +}
>> +
>> +static int constraints_apply(struct icc_path *path)
>> +{
> 
> Nit: maybe name it apply_constraints, since constraints_apply sounds like a
> query (do the constraints apply?).

Ok.

>> +       struct icc_node *next, *prev = NULL;
>> +       int i;
>> +
>> +       for (i = 0; i < path->num_nodes; i++, prev = next) {
>> +               struct icc_provider *provider;
>> +               u32 avg_bw = 0;
>> +               u32 peak_bw = 0;
>> +               int ret;
>> +
>> +               next = path->reqs[i].node;
>> +               /*
>> +                * Both endpoints should be valid master-slave pairs of
> the
>> +                * same interconnect provider that will be configured.
>> +                */
>> +               if (!next || !prev)
>> +                       continue;
>> +
>> +               if (next->provider != prev->provider)
>> +                       continue;
> 
> next should never be null, right? So you could shorten this to if (!prev ||
> (next->provider != prev->provider))

Yes, right. Will do so.

>> +
>> +               provider = next->provider;
>> +               mutex_lock(&provider->lock);
>> +
>> +               /* aggregate requests for the provider */
>> +               provider_aggregate(provider, &avg_bw, &peak_bw);
>> +
>> +               if (provider->set) {
>> +                       /* set the constraints */
>> +                       ret = provider->set(prev, next, avg_bw, peak_bw);
>> +               }
>> +
>> +               mutex_unlock(&provider->lock);
>> +
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * icc_set() - set constraints on an interconnect path between two
> endpoints
>> + * @path: reference to the path returned by icc_get()
>> + * @avg_bw: average bandwidth in kbps
>> + * @peak_bw: peak bandwidth in kbps
>> + *
>> + * This function is used by an interconnect consumer to express its own
> needs
>> + * in term of bandwidth and QoS for a previously requested path between
> two
> 
> "in terms of" rather than "in term of", and not really QoS yet, right?
> 
>> + * endpoints. The requests are aggregated and each node is updated
> accordingly.
>> + *
>> + * Returns 0 on success, or an approproate error code otherwise.
> 
> appropriate
> 

Ok, thanks!

>> + */
>> +int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw)
>> +{
>> +       struct icc_node *node;
>> +       size_t i;
>> +       int ret;
>> +
>> +       if (!path)
>> +               return 0;
> 
> Can we ditch this null check? My understanding is it's generally preferred
> to skip this if it's only there to avoid developer errors.

Ok.

>> +
>> +       for (i = 0; i < path->num_nodes; i++) {
>> +               node = path->reqs[i].node;
>> +
>> +               mutex_lock(&icc_path_mutex);
>> +
>> +               /* update the consumer request for this path */
>> +               path->reqs[i].avg_bw = avg_bw;
>> +               path->reqs[i].peak_bw = peak_bw;
>> +
>> +               /* aggregate requests for this node */
>> +               node_aggregate(node);
>> +
>> +               mutex_unlock(&icc_path_mutex);
>> +       }
>> +
>> +       ret = constraints_apply(path);
>> +       if (ret)
>> +               pr_err("interconnect: error applying constraints (%d)",
> ret);
>> +
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(icc_set);
>> +
>> +/**
>> + * icc_get() - return a handle for path between two endpoints
>> + * @src_id: source device port id
>> + * @dst_id: destination device port id
>> + *
>> + * This function will search for a path between two endpoints and return
> an
>> + * icc_path handle on success. Use icc_put() to release
>> + * constraints when the they are not needed anymore.
>> + *
>> + * Return: icc_path pointer on success, or ERR_PTR() on error
>> + */
>> +struct icc_path *icc_get(const int src_id, const int dst_id)
>> +{
>> +       struct icc_node *src, *dst;
>> +       struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
>> +
>> +       src = node_find(src_id);
>> +       if (!src)
>> +               goto out;
>> +
>> +       dst = node_find(dst_id);
>> +       if (!dst)
>> +               goto out;
>> +
>> +       mutex_lock(&icc_path_mutex);
>> +       path = path_find(src, dst);
>> +       mutex_unlock(&icc_path_mutex);
>> +       if (IS_ERR(path))
>> +               goto out;
>> +
>> +       path_init(path);
>> +
>> +out:
>> +       return path;
>> +}
>> +EXPORT_SYMBOL_GPL(icc_get);
>> +
>> +/**
>> + * icc_put() - release the reference to the icc_path
>> + * @path: interconnect path
>> + *
>> + * Use this function to release the constraints on a path when the path
> is
>> + * no longer needed. The constraints will be re-aggregated.
>> + */
>> +void icc_put(struct icc_path *path)
>> +{
>> +       struct icc_node *node;
>> +       size_t i;
>> +       int ret;
>> +
>> +       if (!path || WARN_ON_ONCE(IS_ERR(path)))
>> +               return;
>> +
>> +       ret = icc_set(path, 0, 0);
>> +       if (ret)
>> +               pr_err("%s: error (%d)\n", __func__, ret);
>> +
>> +       for (i = 0; i < path->num_nodes; i++) {
>> +               node = path->reqs[i].node;
>> +               hlist_del(&path->reqs[i].req_node);
>> +
>> +               mutex_lock(&node->provider->lock);
>> +               node->provider->users--;
>> +               mutex_unlock(&node->provider->lock);
>> +       }
>> +
>> +       kfree(path);
>> +}
>> +EXPORT_SYMBOL_GPL(icc_put);
>> +
>> +/**
>> + * icc_node_create() - create a node
>> + * @id: node id
>> + *
>> + * Return: icc_node pointer on success, or ERR_PTR() on error
>> + */
>> +struct icc_node *icc_node_create(int id)
>> +{
>> +       struct icc_node *node;
>> +
>> +       /* check if node already exists */
>> +       node = node_find(id);
>> +       if (node)
>> +               return node;
> 
> This is probably going to do more harm than good once icc_node_delete comes
> in, since it almost certainly indicates a programmer error or ID collision,
> and will likely result in a double free. We should probably fail with
> EEXIST instead.

In the current approach we create the nodes one by one, and the linked
nodes are created when they are referenced. The other way around would
be to create first all the nodes and then populate the links to avoid
the "chicken and egg" problem.

>> +
>> +       node = kzalloc(sizeof(*node), GFP_KERNEL);
>> +       if (!node)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       id = idr_alloc(&icc_idr, node, id, id + 1, GFP_KERNEL);
>> +       if (WARN(id < 0, "couldn't get idr"))
>> +               return ERR_PTR(id);
>> +
>> +       node->id = id;
>> +
>> +       return node;
>> +}
>> +EXPORT_SYMBOL_GPL(icc_node_create);
>> +
>> +/**
>> + * icc_link_create() - create a link between two nodes
>> + * @src_id: source node id
>> + * @dst_id: destination node id
>> + *
>> + * Return: 0 on success, or an error code otherwise
>> + */
>> +int icc_link_create(struct icc_node *node, const int dst_id)
>> +{
>> +       struct icc_node *dst;
>> +       struct icc_node **new;
>> +       int ret = 0;
>> +
>> +       if (IS_ERR_OR_NULL(node))
>> +               return PTR_ERR(node);
> 
> Remove this.

Ok.

>> +
>> +       mutex_lock(&node->provider->lock);
>> +
>> +       dst = node_find(dst_id);
>> +       if (!dst)
>> +               dst = icc_node_create(dst_id);
> 
> icc_node_create can fail, you should fail here if it does.

Ok.

>> +
>> +       new = krealloc(node->links,
>> +                      (node->num_links + 1) * sizeof(*node->links),
>> +                      GFP_KERNEL);
>> +       if (!new) {
>> +               ret = -ENOMEM;
>> +               goto out;
>> +       }
>> +
>> +       node->links = new;
>> +       node->links[node->num_links++] = dst;
>> +
>> +out:
>> +       mutex_unlock(&node->provider->lock);
>> +
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(icc_link_create);
>> +
>> +/**
>> + * icc_add_node() - add an interconnect node to interconnect provider
>> + * @node: pointer to the interconnect node
>> + * @provider: pointer to the interconnect provider
>> + *
>> + * Return: 0 on success, or an error code otherwise
>> + */
>> +int icc_node_add(struct icc_node *node, struct icc_provider *provider)
>> +{
>> +       if (WARN_ON(!node))
>> +               return -EINVAL;
>> +
>> +       if (WARN_ON(!provider))
>> +               return -EINVAL;
> 
> Remove these.

Ok.

>> +
>> +       node->provider = provider;
>> +
>> +       mutex_lock(&provider->lock);
>> +       list_add_tail(&node->node_list, &provider->nodes);
>> +       mutex_unlock(&provider->lock);
>> +
>> +       return 0;
>> +}
> 
> icc_node_add should be exported, right? I see it being used in msm8916.c.
> You should make sure that "make allmodconfig" still builds with your
> changes.

Yes. Agree.

> 
> I think you should add a safety check in icc_link_create to ensure that the
> node has a provider before adding any links. If some consumer made a
> mistake and added links before adding the node to the provider, path
> traversal would use the uninitialized or NULL provider pointer. I was
> thinking about this while noticing that you assign node->provider before
> acquiring the lock.

Ok.

>> +
>> +/**
>> + * icc_add_provider() - add a new interconnect provider
>> + * @icc_provider: the interconnect provider that will be added into
> topology
>> + *
>> + * Return: 0 on success, or an error code otherwise
>> + */
>> +int icc_add_provider(struct icc_provider *provider)
>> +{
>> +       if (WARN_ON(!provider))
>> +               return -EINVAL;
>> +
> 
> Remove this one. The one below is okay.

Ok.

>> +       if (WARN_ON(!provider->set))
>> +               return -EINVAL;
>> +
>> +       mutex_init(&provider->lock);
>> +       INIT_LIST_HEAD(&provider->nodes);
>> +
>> +       mutex_lock(&icc_provider_list_mutex);
>> +       list_add(&provider->provider_list, &icc_provider_list);
>> +       mutex_unlock(&icc_provider_list_mutex);
>> +
>> +       dev_dbg(provider->dev, "interconnect provider added to
> topology\n");
>> +
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(icc_add_provider);
>> +
>> +/**
>> + * icc_del_provider() - delete previously added interconnect provider
>> + * @icc_provider: the interconnect provider that will be removed from
> topology
>> + *
>> + * Return: 0 on success, or an error code otherwise
>> + */
>> +int icc_del_provider(struct icc_provider *provider)
>> +{
>> +       mutex_lock(&provider->lock);
>> +       if (provider->users) {
>> +               pr_warn("interconnect provider still has %d users\n",
>> +                       provider->users);
>> +       }
>> +       mutex_unlock(&provider->lock);
>> +
>> +       mutex_lock(&icc_provider_list_mutex);
>> +       list_del(&provider->provider_list);
>> +       mutex_unlock(&icc_provider_list_mutex);
>> +
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(icc_del_provider);
>> +
>> +MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org");
>> +MODULE_DESCRIPTION("Interconnect Driver Core");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/linux/interconnect-provider.h
> b/include/linux/interconnect-provider.h
>> new file mode 100644
>> index 000000000000..779b5b5b1306
>> --- /dev/null
>> +++ b/include/linux/interconnect-provider.h
>> @@ -0,0 +1,109 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (c) 2018, Linaro Ltd.
>> + * Author: Georgi Djakov <georgi.djakov@linaro.org>
>> + */
>> +
>> +#ifndef _LINUX_INTERCONNECT_PROVIDER_H
>> +#define _LINUX_INTERCONNECT_PROVIDER_H
>> +
>> +#include <linux/interconnect.h>
>> +
>> +struct icc_node;
>> +
>> +/**
>> + * struct icc_provider - interconnect provider (controller) entity that
> might
>> + * provide multiple interconnect controls
>> + *
>> + * @provider_list: list of the registered interconnect providers
>> + * @nodes: internal list of the interconnect provider nodes
>> + * @set: pointer to device specific set operation function
>> + * @dev: the device this interconnect provider belongs to
>> + * @lock: lock to provide consistency during aggregation/update of
> constraints
>> + * @users: count of active users
>> + * @data: pointer to private data
>> + */
>> +struct icc_provider {
>> +       struct list_head        provider_list;
>> +       struct list_head        nodes;
>> +       int (*set)(struct icc_node *src, struct icc_node *dst,
>> +                  u32 avg_bw, u32 peak_bw);
>> +       struct device           *dev;
>> +       struct mutex            lock;
>> +       int                     users;
>> +       void                    *data;
>> +};
>> +
>> +/**
>> + * struct icc_node - entity that is part of the interconnect topology
>> + *
>> + * @id: platform specific node id
>> + * @name: node name used in debugfs
>> + * @links: a list of targets where we can go next when traversing
>> + * @num_links: number of links to other interconnect nodes
>> + * @provider: points to the interconnect provider of this node
>> + * @node_list: list of interconnect nodes associated with @provider
>> + * @search_list: list used when walking the nodes graph
>> + * @reverse: pointer to previous node when walking the nodes graph
>> + * @is_traversed: flag that is used when walking the nodes graph
>> + * @req_list: a list of QoS constraint requests associated with this node
>> + * @avg_bw: aggregated value of average bandwidth
>> + * @peak_bw: aggregated value of peak bandwidth
>> + * @data: pointer to private data
>> + */
>> +struct icc_node {
>> +       int                     id;
> 
> Why int here? Are you expecting negative numbers? Maybe u32 instead? Or
> even better, maybe a typedef u32 icc_id? Ooh yeah, that way we know when
> parameters and such are passed around that they refer to this.

It's an int, just to be aligned with the idr API. u32 would also work.

>> +       const char              *name;
>> +       struct icc_node         **links;
>> +       size_t                  num_links;
>> +
>> +       struct icc_provider     *provider;
>> +       struct list_head        node_list;
> 
> So the difference between node_list and links is that node_list nodes live
> inside this node, whereas links point at other peers?
> 
> Oh no, I get it now after reading the .c file: node_list is the list entry
> in the parent provider's "nodes" list. The comment description could be
> clearer about that.

Ok. Will improve the wording.

Thanks,
Georgi
