Return-Path: <christian.brauner@canonical.com>
X-Google-Smtp-Source: AB8JxZoa1lIsalcCeGwI4k4RtWEidy3/8uMupE1q4Qdku8pb3Qnn6Ey8jGrY+j7rPAjguFnX1bIl
ARC-Seal: i=1; a=rsa-sha256; t=1524818520; cv=none;
        d=google.com; s=arc-20160816;
        b=imXZKrQCe2cc4gxmmPuNYPnClO5fXqYsjFZxvLiRPN5yGa1ZmN4NsBPvZrdsh9PKSQ
         HJy2s6agEFiNcM+wT5BX0Afi2fHWZ8QieoyxmkeBYVTibTtFuD8cVlwja7hadAkg77Kb
         XHJod5W97w8oEdl7/1gWT5vRTS1xB1Je+sXzH6Nl+9BT5u2ThVx168qQU6CamjJcND29
         y608zYiU6HE855tvVshgs9subqh/czVqunfprygDe0V1cGUVv8CN90JS0HB8peM82232
         QNepyMd2Y/290erz4ax4uePIKqgJJzP2svt3pjXl/BKQMX2m6zyY6IrKeT+Ac7RHVNy+
         8W4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:arc-authentication-results;
        bh=8LZU1A54sAga+wTXhbQgt82pr2V0coLp00uerT/EzYY=;
        b=vtB9mE+MSeVlrvZyL1eRRdYu0Uo6OVfWRgE+FEAl0sSo1bD3nkTlP+eRZfH2/qynKO
         2TSQHgtTAIu5zfkk1NS84GOgCegVGXq2LW+nXWt1kTV0gAn2mxvaQ3Bm6hHZP6E3QaIw
         91ULirDtoBXSyeQZEpRPtXr5r2z3ZSIXtpUmObV8iRFOGzlCbredwGbs0L2qsgqoOsHe
         tBBeN1HyOYAyXgV4YI3/7xNM9v+B8OD5UbSfSdA7+4oMh6/wD1T4c46DXjukfjQB6TNa
         bxA7gx5pJ4IkRLD/6TVmrVCNr+Rakcw1ncvEFD8TxFWNTegO0/xPA5qT2Ah5Z51ffQ7N
         o3cA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Fri, 27 Apr 2018 10:41:58 +0200
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, avagin@virtuozzo.com,
	ktkhai@virtuozzo.com, serge@hallyn.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH net-next 1/2 v2] netns: restrict uevents
Message-ID: <20180427084157.GA29044@gmail.com>
References: <20180424204335.12904-2-christian.brauner@ubuntu.com>
 <87po2oz0s8.fsf@xmission.com>
 <CAPP7u0WH9w26Y9ai-EQTTeq7Rz_=7u2-=t4nhHmjwh-UAiyqeQ@mail.gmail.com>
 <87wowww6p8.fsf@xmission.com>
 <20180426161353.GA2014@gmail.com>
 <871sf1q5ig.fsf@xmission.com>
 <20180426170324.GA10061@gmail.com>
 <878t99opvd.fsf@xmission.com>
 <20180426212744.GA30270@gmail.com>
 <87vacdbi58.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87vacdbi58.fsf@xmission.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598661751720131852?=
X-GMAIL-MSGID: =?utf-8?q?1598888105374685617?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 07:35:47PM -0500, Eric W. Biederman wrote:
> Christian Brauner <christian.brauner@canonical.com> writes:
> 
> > On Thu, Apr 26, 2018 at 12:10:30PM -0500, Eric W. Biederman wrote:
> >> Christian Brauner <christian.brauner@canonical.com> writes:
> >> 
> >> > On Thu, Apr 26, 2018 at 11:47:19AM -0500, Eric W. Biederman wrote:
> >> >> Christian Brauner <christian.brauner@canonical.com> writes:
> >> >> 
> >> >> > On Tue, Apr 24, 2018 at 06:00:35PM -0500, Eric W. Biederman wrote:
> >> >> >> Christian Brauner <christian.brauner@canonical.com> writes:
> >> >> >> 
> >> >> >> > On Wed, Apr 25, 2018, 00:41 Eric W. Biederman <ebiederm@xmission.com> wrote:
> >> >> >> >
> >> >> >> >  Bah. This code is obviously correct and probably wrong.
> >> >> >> >
> >> >> >> >  How do we deliver uevents for network devices that are outside of the
> >> >> >> >  initial user namespace? The kernel still needs to deliver those.
> >> >> >> >
> >> >> >> >  The logic to figure out which network namespace a device needs to be
> >> >> >> >  delivered to is is present in kobj_bcast_filter. That logic will almost
> >> >> >> >  certainly need to be turned inside out. Sign not as easy as I would
> >> >> >> >  have hoped.
> >> >> >> >
> >> >> >> > My first patch that we discussed put additional filtering logic into kobj_bcast_filter for that very reason. But I can move that logic
> >> >> >> > out and come up with a new patch.
> >> >> >> 
> >> >> >> I may have mis-understood.
> >> >> >> 
> >> >> >> I heard and am still hearing additional filtering to reduce the places
> >> >> >> the packet is delievered.
> >> >> >> 
> >> >> >> I am saying something needs to change to increase the number of places
> >> >> >> the packet is delivered.
> >> >> >> 
> >> >> >> For the special class of devices that kobj_bcast_filter would apply to
> >> >> >> those need to be delivered to netowrk namespaces  that are no longer on
> >> >> >> uevent_sock_list.
> >> >> >> 
> >> >> >> So the code fundamentally needs to split into two paths.  Ordinary
> >> >> >> devices that use uevent_sock_list.  Network devices that are just
> >> >> >> delivered in their own network namespace.
> >> >> >> 
> >> >> >> netlink_broadcast_filtered gets to go away completely.
> >> >> >
> >> >> > The split *might* make sense but I think you're wrong about removing the
> >> >> > kobj_bcast_filter. The current filter doesn't operate on the uevent
> >> >> > socket in uevent_sock_list itself it rather operates on the sockets in
> >> >> > mc_list. And if socket in mc_list can have a different network namespace
> >> >> > then the uevent_socket itself then your way won't work. That's why my
> >> >> > original patch added additional filtering in there. The way I see it we
> >> >> > need something like:
> >> >> 
> >> >> We already filter the sockets in the mc_list by network namespace.
> >> >
> >> > Oh really? That's good to know. I haven't found where in the code this
> >> > actually happens. I thought that when netlink_bind() is called anyone
> >> > could register themselves in mc_list.
> >> 
> >> The code in af_netlink.c does:
> >> > static void do_one_broadcast(struct sock *sk,
> >> > 				    struct netlink_broadcast_data *p)
> >> > {
> >> > 	struct netlink_sock *nlk = nlk_sk(sk);
> >> > 	int val;
> >> > 
> >> > 	if (p->exclude_sk == sk)
> >> > 		return;
> >> > 
> >> > 	if (nlk->portid == p->portid || p->group - 1 >= nlk->ngroups ||
> >> > 	    !test_bit(p->group - 1, nlk->groups))
> >> > 		return;
> >> > 
> >> > 	if (!net_eq(sock_net(sk), p->net)) {
> >>             ^^^^^^^^^^^^ Here
> >> > 		if (!(nlk->flags & NETLINK_F_LISTEN_ALL_NSID))
> >> > 			return;
> >>                 ^^^^^^^^^^^ Here
> >> > 
> >> > 		if (!peernet_has_id(sock_net(sk), p->net))
> >> > 			return;
> >> > 
> >> > 		if (!file_ns_capable(sk->sk_socket->file, p->net->user_ns,
> >> > 				     CAP_NET_BROADCAST))
> >> > 			return;
> >> > 	}
> >> 
> >> Which if you are not a magic NETLINK_F_LISTEN_ALL_NSID socket filters
> >> you out if you are the wrong network namespace.
> >> 
> >> 
> >> >> When a packet is transmitted with netlink_broadcast it is only
> >> >> transmitted within a single network namespace.
> >> >> 
> >> >> Even in the case of a NETLINK_F_LISTEN_ALL_NSID socket the skb is tagged
> >> >> with it's source network namespace so no confusion will result, and the
> >> >> permission checks have been done to make it safe. So you can safely
> >> >> ignore that case.  Please ignore that case.  It only needs to be
> >> >> considered if refactoring af_netlink.c
> >> >> 
> >> >> When I added netlink_broadcast_filtered I imagined that we would need
> >> >> code that worked across network namespaces that worked for different
> >> >> namespaces.   So it looked like we would need the level of granularity
> >> >> that you can get with netlink_broadcast_filtered.  It turns out we don't
> >> >> and that it was a case of over design.  As the only split we care about
> >> >> is per network namespace there is no need for
> >> >> netlink_broadcast_filtered.
> >> >> 
> >> >> > init_user_ns_broadcast_filtered(uevent_sock_list, kobj_bcast_filter);
> >> >> > user_ns_broadcast_filtered(uevent_sock_list,kobj_bcast_filter);
> >> >> >
> >> >> > The question that remains is whether we can rely on the network
> >> >> > namespace information we can gather from the kobject_ns_type_operations
> >> >> > to decide where we want to broadcast that event to. So something
> >> >> > *like*:
> >> >> 
> >> >> We can.  We already do.  That is what kobj_bcast_filter implements.
> >> >> 
> >> >> > 	ops = kobj_ns_ops(kobj);
> >> >> > 	if (!ops && kobj->kset) {
> >> >> > 		struct kobject *ksobj = &kobj->kset->kobj;
> >> >> > 		if (ksobj->parent != NULL)
> >> >> > 			ops = kobj_ns_ops(ksobj->parent);
> >> >> > 	}
> >> >> >
> >> >> > 	if (ops && ops->netlink_ns && kobj->ktype->namespace)
> >> >> > 		if (ops->type == KOBJ_NS_TYPE_NET)
> >> >> > 			net = kobj->ktype->namespace(kobj);
> >> >> 
> >> >> Please note the only entry in the enumeration in the kobj_ns_type
> >> >> enumeration other than KOBJ_NS_TYPE_NONE is KOBJ_NS_TYPE_NET.  So the
> >> >> check for ops->type in this case is redundant.
> >> >
> >> > Yes, I know the reason for doing it explicitly is to block the case
> >> > where kobjects get tagged with other namespaces. So we'd need to be
> >> > vigilant should that ever happen but fine.
> >> 
> >> It is fine to keep the check.
> >> 
> >> I was intending to point out that it is much more likely that we remove
> >> the enumeration and remove some of the extra abstraction, than another
> >> namespace is implemented there.
> >> 
> >> >> That is something else that could be simplifed.  At the time it was the
> >> >> necessary to get the sysfs changes merged.
> >> >> 
> >> >> > 	if (!net || net->user_ns == &init_user_ns)
> >> >> > 		ret = init_user_ns_broadcast(env, action_string, devpath);
> >> >> > 	else
> >> >> > 		ret = user_ns_broadcast(net->uevent_sock->sk, env,
> >> >> > 					action_string, devpath);
> >> >> 
> >> >> Almost.
> >> >> 
> >> >> 	if (!net)
> >> >>         	kobject_uevent_net_broadcast(kobj, env, action_string,
> >> >>         					dev_path);
> >> >> 	else
> >> >>         	netlink_broadcast(net->uevent_sock->sk, skb, 0, 1, GFP_KERNEL);
> >> >> 
> >> >> 
> >> >> I am handwaving to get the skb in the netlink_broadcast case but that
> >> >> should be enough for you to see what I am thinking.
> >> >
> >> > I have added a helper alloc_uevent_skb() that can be used in both cases.
> >> >
> >> > static struct sk_buff *alloc_uevent_skb(struct kobj_uevent_env *env,
> >> > 					const char *action_string,
> >> > 					const char *devpath)
> >> > {
> >> > 	struct sk_buff *skb = NULL;
> >> > 	char *scratch;
> >> > 	size_t len;
> >> >
> >> > 	/* allocate message with maximum possible size */
> >> > 	len = strlen(action_string) + strlen(devpath) + 2;
> >> > 	skb = alloc_skb(len + env->buflen, GFP_KERNEL);
> >> > 	if (!skb)
> >> > 		return NULL;
> >> >
> >> > 	/* add header */
> >> > 	scratch = skb_put(skb, len);
> >> > 	sprintf(scratch, "%s@%s", action_string, devpath);
> >> >
> >> > 	skb_put_data(skb, env->buf, env->buflen);
> >> >
> >> > 	NETLINK_CB(skb).dst_group = 1;
> >> >
> >> > 	return skb;
> >> > }
> >> >
> >> >> 
> >> >> My only concern with the above is that we almost certainly need to fix
> >> >> the credentials on the skb so that userspace does not drop the packet
> >
> > I guess we simply want:
> > 	if (user_ns != &init_user_ns) {
> > 		NETLINK_CB(skb).creds.uid = (kuid_t)0;
> > 		NETLINK_CB(skb).creds.gid = kgid_t)0;
> > 	}
> 
> I believe the above is what we already have.
> 
> > instead of the more complicated and - imho wrong:
> >
> > 	if (user_ns != &init_user_ns) {
> > 		/* fix credentials for udev running in user namespace */
> > 		kuid_t uid = NETLINK_CB(skb).creds.uid;
> > 		kgid_t gid = NETLINK_CB(skb).creds.gid;
> > 		NETLINK_CB(skb).creds.uid = from_kuid_munged(user_ns, uid);
> > 		NETLINK_CB(skb).creds.gid = from_kgid_munged(user_ns, gid);
> > 	}
> 
> The above is most definitely wrong as we store kuids and kgids in
> "NETLINK_CB(skb).creds".
> 
> I am pretty certain what we want is:
> 	kuid_t root_uid = make_kuid(net->user_ns, 0);
>         kgid_g root_gid = make_kgid(net->user_ns, 0);

Thanks! I looked at user_namespace.c which contained map_id_down() which
is the function that I wanted and remembered from a prior patchset of
mine but they weren't exported. I didn't spot make_k{g,u}id() which are
wrapping those. These are the droids^H^H^H^H^H^Hfunctions I was looking
for!

>         if (!uid_valid(root_uid))
>         	root_uid = GLOBAL_ROOT_UID;
> 	if (!gid_valid(root_gid))
>         	root_gid = GLOBAL_ROOT_GID;
> 	NETLINK_CB(skb).creds.uid = root_uid;
>         NETLINK_CB(skb).creds.gid = root_gid;
> 
> Let's be careful and only fix this for the networking uevents please.
> We want the other onces to just go away.

This is already handled by the

if (!net)
       handle_untagged_uevents()
else
       handle_taggged_uevents()

The else branch will only every contain network devices as to my
knowledge no other kernel devices are currently tagged.

Thanks!
Christian

> 
> The networking uevents we have to fix or they will be gone completely.
> 
> Eric
