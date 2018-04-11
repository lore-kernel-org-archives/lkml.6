Return-Path: <ebiederm@xmission.com>
X-Google-Smtp-Source: AIpwx49pIOPeI4NHTfTT0EqoqauV4lsmKXbQw7f2vT+gY2Wfvil56SfsJbwRnkRzRQ4GbyEpADLb
ARC-Seal: i=1; a=rsa-sha256; t=1523474262; cv=none;
        d=google.com; s=arc-20160816;
        b=qpWXXVv3x1mCTz3uQfzZUC3Ii2SsRbTICsgZAZL3iH8KKTfDMRuk6E6V61BZGZK2fI
         MITXJU5KDFS32DucbfDker6FGBYx1VVHZurRfqGM5e4ZLHGlxWOxQ0Om7hF2nff+a8QP
         x4t4vlcY1wfUBo46QPCP9CdzzePzS7XZP1hJG41ODi5nMqzLkIu9tjfhyW74uGFgYsq5
         hPiaMIUK0kW/pf2XXBwsrtdYNazgGHTgprY6UXcPl3mJRMTgvf3cDmGRjhVFGs30wBGd
         uqf0w7ESwGYspsHmgS7OZRfvuQbugHQ0YICGUyYIUz3ONmv2/wmaySazPu6vDtgcLpWI
         Fibg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:mime-version:user-agent:message-id:in-reply-to:date
         :references:cc:to:from:arc-authentication-results;
        bh=j2QF+dDPUuBM2tpMbd0GeZgS12iWX9aUeF9TqWr1Ykc=;
        b=zYcFYNTXQvKzC9f+fO8hZBEsMunf7LxrRiPOzdtLHJQ5sOjOTmGXh/S4j3UCuHqVDY
         A+9krd5HGC8Syytd2FHMEvvtLSBrSjMP1PB3EylMP9PxE6FPqMuBZybWCp6r/8Q06SS1
         YVLH1CBoyay04cKM8ma3oaizQoNVCIUXtriyen720Ady0rRpK1AFjVuW1KqpKqYMV52x
         1hpSs/3AKYtUAfL0owYoIHnTphCWolfF/GYJJjHMQ7LKdrE95l1gOuBwxcG5OvQUN8E9
         Q+tnepT0xaclezn8eyeb5PuA6nNiadvSlFj88qHpbhjiwBGOTT8l05vd9ytURZzfG1GI
         WWVA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.233 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.233 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christian Brauner <christian.brauner@canonical.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>,  davem@davemloft.net,  gregkh@linuxfoundation.org,  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,  avagin@virtuozzo.com,  serge@hallyn.com
References: <20180405144130.GB26043@gmail.com> <87in953ryi.fsf@xmission.com>
	<20180409154627.GA15157@gmail.com> <878t9wx8xw.fsf@xmission.com>
	<20180410143515.GA14186@gmail.com> <87in8zumpd.fsf@xmission.com>
	<20180411090907.GA20340@gmail.com> <87tvshlms1.fsf@xmission.com>
	<20180411170333.GA4319@gmail.com> <87efjllhcx.fsf@xmission.com>
	<20180411185715.GA15862@gmail.com>
Date: Wed, 11 Apr 2018 14:16:23 -0500
In-Reply-To: <20180411185715.GA15862@gmail.com> (Christian Brauner's message
	of "Wed, 11 Apr 2018 20:57:16 +0200")
Message-ID: <871sflk0zc.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f6LFS-0003ri-78;;;mid=<871sflk0zc.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.140.30;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+VBS5hm0LUa9XDAP6+qlSd7ILk8bp9QFU=
X-SA-Exim-Connect-IP: 97.119.140.30
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4812]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Brauner <christian.brauner@canonical.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1395 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 6 (0.4%), b_tie_ro: 4.0 (0.3%), parse: 0.96 (0.1%),
	extract_message_metadata: 17 (1.2%), get_uri_detail_list: 3.3 (0.2%),
	tests_pri_-1000: 9 (0.6%), tests_pri_-950: 1.20 (0.1%), tests_pri_-900: 1.00
	(0.1%), tests_pri_-400: 33 (2.4%), check_bayes: 32 (2.3%), b_tokenize: 11
	(0.8%), b_tok_get_all: 11 (0.8%), b_comp_prob: 3.2 (0.2%), b_tok_touch_all:
	3.1 (0.2%), b_finish: 0.55 (0.0%), tests_pri_0: 1318 (94.5%),
	check_dkim_signature: 0.78 (0.1%), check_dkim_adsp: 2.6 (0.2%),
	tests_pri_500: 6 (0.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH net-next] netns: filter uevents correctly
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596846368169451603?=
X-GMAIL-MSGID: =?utf-8?q?1597478547961084139?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Christian Brauner <christian.brauner@canonical.com> writes:

> On Wed, Apr 11, 2018 at 01:37:18PM -0500, Eric W. Biederman wrote:
>> Christian Brauner <christian.brauner@canonical.com> writes:
>> 
>> > On Wed, Apr 11, 2018 at 11:40:14AM -0500, Eric W. Biederman wrote:
>> >> Christian Brauner <christian.brauner@canonical.com> writes:
>> >> > Yeah, agreed.
>> >> > But I think the patch is not complete. To guarantee that no non-initial
>> >> > user namespace actually receives uevents we need to:
>> >> > 1. only sent uevents to uevent sockets that are located in network
>> >> >    namespaces that are owned by init_user_ns
>> >> > 2. filter uevents that are sent to sockets in mc_list that have opened a
>> >> >    uevent socket that is owned by init_user_ns *from* a
>> >> >    non-init_user_ns
>> >> >
>> >> > We account for 1. by only recording uevent sockets in the global uevent
>> >> > socket list who are owned by init_user_ns.
>> >> > But to account for 2. we need to filter by the user namespace who owns
>> >> > the socket in mc_list. So in addition to that we also need to slightly
>> >> > change the filter logic in kobj_bcast_filter() I think:
>> >> >
>> >> > diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
>> >> > index 22a2c1a98b8f..064d7d29ace5 100644
>> >> > --- a/lib/kobject_uevent.c
>> >> > +++ b/lib/kobject_uevent.c
>> >> > @@ -251,7 +251,8 @@ static int kobj_bcast_filter(struct sock *dsk, struct sk_buff *skb, void *data)
>> >> >  		return sock_ns != ns;
>> >> >  	}
>> >> >  
>> >> > -	return 0;
>> >> > + 	/* Check if socket was opened from non-initial user namespace. */
>> >> > + 	return sk_user_ns(dsk) != &init_user_ns;
>> >> >  }
>> >> >  #endif
>> >> >  
>> >> >
>> >> > But correct me if I'm wrong.
>> >> 
>> >> You are worrying about NETLINK_LISTEN_ALL_NSID sockets.  That has
>> >> permissions and an explicit opt-in to receiving packets from multiple
>> >> network namespaces.
>> >
>> > I don't think that's what I'm talking about unless that is somehow the
>> > default for NETLINK_KOBJECT_UEVENT sockets. What I'm worried about is
>> > doing
>> >
>> > unshare -U --map-root
>> >
>> > then opening a NETLINK_KOBJECT_UEVENT socket and starting to listen to
>> > uevents. Imho, this should not be possible because I'm in a
>> > non-init_user_ns. But currently I'm able to - even with the patch to
>> > come - since the uevent socket in the kernel was created when init_net
>> > was created and hence is *owned* by the init_user_ns which means it is
>> > in the list of uevent sockets. Here's a demo of what I mean:
>> >
>> > https://asciinema.org/a/175632
>> 
>> Why do you care about this case?
>
> It's not so much that I care about this case since any workload that
> wants to run a separate udevd will have to unshare the network namespace
> and the user namespace for it to make complete sense.
> What I do care about is that the two of us are absolutely in the clear
> about what semantics we are going to expose to userspace and it seems
> that we were talking past each other wrt to this "corner case".
> For userspace, it needs to be very clear that the intention is to filter
> by *owning user namespace of the network namespace a given task resides
> in* and not by user namespace of the task per se. This is what this
> corner case basically shows, I think.

If this is just a clarification of semantics then yes this is a
productive question.  I almost agree with your definition above.

I would make the definition very simple.  Uevents will not be broadcast
via netlink in a network namespace where net->user_ns != &init_user_ns,
with the exception of uevents for network devices in that network
namespace.

The existing filtering by the sending uid and verifying that it is uid 0
gives a little more room to filter if we want (as udev & friends will
ignore the uevent), but I don't see the point.

Eric
