Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752087AbeBDRVe (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 12:21:34 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:34776 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbeBDRVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 12:21:23 -0500
X-Google-Smtp-Source: AH8x227JJWZ5d3Uwg97pOKPw0q3iC2Ugv4pivNqsR6uVQfiKM5nhF4CQbDwzyNUQtZMZyZuMTTPRdA==
Subject: Re: [PATCH net 1/1 v1] rtnetlink: require unique netns identifier
To: Christian Brauner <christian.brauner@canonical.com>,
        Stephen Hemminger <stephen@networkplumber.org>
Cc: Christian Brauner <christian.brauner@ubuntu.com>,
        netdev@vger.kernel.org, ebiederm@xmission.com, jbenc@redhat.com,
        nicolas.dichtel@6wind.com, linux-kernel@vger.kernel.org,
        davem@davemloft.net
References: <20180203132904.11972-1-christian.brauner@ubuntu.com>
 <20180203132904.11972-2-christian.brauner@ubuntu.com>
 <20180203111701.2ff8d7a3@xeon-e3> <20180204121100.GA1344@gmail.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <3b619bb9-f6cb-6ca9-955b-01c87132c389@gmail.com>
Date: Sun, 4 Feb 2018 10:21:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180204121100.GA1344@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/18 5:11 AM, Christian Brauner wrote:
> On Sat, Feb 03, 2018 at 11:17:01AM -0800, Stephen Hemminger wrote:
>> On Sat,  3 Feb 2018 14:29:04 +0100
>> Christian Brauner <christian.brauner@ubuntu.com> wrote:
>>
>>> +static int rtnl_ensure_unique_netns_attr(const struct sock *sk,
>>> +					 struct nlattr *tb[],
>>> +					 struct netlink_ext_ack *extack)
>>> +{
>>> +	int ret = -EINVAL;
>>> +	struct net *net = NULL, *unique_net = NULL;
>>> +
>>> +	/* Requests without network namespace ids have been able to specify
>>> +	 * multiple properties referring to different network namespaces so
>>> +	 * don't regress them.
>>> +	 */
>>> +	if (!tb[IFLA_IF_NETNSID])
>>> +		return 0;
>>> +
>>> +	if (!tb[IFLA_NET_NS_PID] && !tb[IFLA_NET_NS_FD])
>>> +		return 0;
>>
>> Isn't this an error?
> 
> My reasoning was that having no explicit network namespace identifying
> attributes the caller operates on the current network namespace which is
> uniquely identified.

agreed. those are not required attributes.
