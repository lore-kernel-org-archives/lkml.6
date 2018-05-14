Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1071218-1526316754-2-17938507029377041927
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526316753; b=noMwSXSdchpmiwP75zd5vjwdGWEDRIoWTDL2Tyri76ckO724wb
    mw8bceJGQH5HiY+wS7mXEVHiHWZ4zj/Pk0pNTWcRcdOWmUdJMaftU+b2xB/GWJ+V
    vRf8zrv7Qw4amV7Z3ddVpa+iYqz+5olPgslJZATKzLs5t6Bzf9uqQ5E1AWJEnCG2
    2TantgyPb4WBC72UCaA11S8V8svHyXz9YflEJFuXWa39507rgO1MZVFjOYyfgKS6
    oguoDELqc/DdjqpHyP7Zosn106w0UsSMBx+lyzn6s/VgdqELVklsJuZa1k1X6oEM
    ShtpWJsbkFvsB4EMD4SfymTP0V8TjEhi7SVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526316753;
    bh=N5ljqOQF9/TnmChAgksueX2SHQyP+1GGCi9ApsYztpA=; b=PcxRR4hsHDoA
    fwDD3Gz+NXWqqA9Eb+zL30C7tIkuXDGJ+w30rqd4S0gPKLHYIlsDhJpTrDi0cvcl
    k1HHc6ubela9ucuXaXHhyFTwAcrAD1MJjuG2bY5KQcaM4X2fY91cso5vWXHiX/5/
    0SjdcbPd8l8B4fAKDLo8WwqdxjsjDpo7vMEJKP7xgytVKaXAz5DG/TT3jSJjM/gf
    z8O9iEZOlrG0Q8IqbEf1Gls8tQnDSjLtO5ue8pd2eE7fiwQ4ViiucywoaUZLcV6w
    CeC/NGOIYBIVr2kYoNULm16M3iyGp/ogGTNNVldV7ec6Df36dGUacdNdD+Z1b9f/
    S7x/8X+8rA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tycho.nsa.gov;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=tycho.nsa.gov header.result=pass
    header_org.domain=nsa.gov header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-110 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tycho.nsa.gov;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=tycho.nsa.gov header.result=pass
      header_org.domain=nsa.gov header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-110 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOocFcSHwWOeHqLLpdtHh1iijsiM825Ijm6qeywwN1raHbvR5q9HlxnJIQnNYbqfFRIUqa8Y+Jy8HSn8zAC2y5dzDGNTJQ0k3hvXZQmQzIBsBXZhUztw
    z0vg0WS2EpqpH+kqgrOO+r4er4JAv9NsP/bqCp8YLFrzkUXfBz/dd8vGNkUZeqlsi/FBPCJbpLUJD0xoB/D/ENeSlYIGptJaEDFbvgNicukNjePM6PE23RkP
    N78RHf6c8PyEdhkUYGyJMA==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=vpqfxihKAAAA:8 a=VwQbUJbxAAAA:8 a=CCwfxW2PiVYQqv4tuh0A:9
    a=rSZn5ObO2yyV6kM6:21 a=UsSk9cScvg4njPSF:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AULIiLoY-XQsE5F6gcqX:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753116AbeENQwa (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 12:52:30 -0400
Received: from ucol19pa12.eemsg.mail.mil ([214.24.24.85]:29788 "EHLO
        ucol19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752132AbeENQw3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 14 May 2018 12:52:29 -0400
X-IronPort-AV: E=Sophos;i="5.49,400,1520899200";
   d="scan'208";a="560102463"
X-IronPort-AV: E=Sophos;i="5.49,400,1520899200";
   d="scan'208";a="11761760"
IronPort-PHdr: =?us-ascii?q?9a23=3ABfro1hx/ax3wCcTXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0u0XI/ad9pjvdHbS+e9qxAeQG9mDsLQc06L/iOPJYSQ4+5GPsXQPItRndi?=
 =?us-ascii?q?QuroEopTEmG9OPEkbhLfTnPGQQFcVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBg?=
 =?us-ascii?q?vwNRZvJuTyB4Xek9m72/q99pHPbQhEniaxba9vJxiqsAvdsdUbj5F/Iagr0B?=
 =?us-ascii?q?vJpXVIe+VSxWx2IF+Yggjx6MSt8pN96ipco/0u+dJOXqX8ZKQ4UKdXDC86PG?=
 =?us-ascii?q?Av5c3krgfMQA2S7XYBSGoWkx5IAw/Y7BHmW5r6ryX3uvZh1CScIMb7Vq4/Vy?=
 =?us-ascii?q?i84Kh3SR/okCYHOCA/8GHLkcx7kaZXrAu8qxBj34LYZYeYO/RkfqPZYNgUW2?=
 =?us-ascii?q?xPUMhMXCBFG4+wcZcDA+8HMO1FrYfyukEOoAOjCweyCuPhyjxGiHH40qI10e?=
 =?us-ascii?q?suDQ7I0Rc8H98MqnnYsMn5OakQXO2z0aLGzS/Db/RT2Trl9YbIbg4uoemMXb?=
 =?us-ascii?q?1ud8ra1FQhFwbfgVWUrYzqITOU3fkKvmiA8uVgTvmii3Inqg5tojivwd0gio?=
 =?us-ascii?q?/Sho0P0FzE+iJ5wJgsKNC+VUV1YsakHYNNuyyVOIZ6WMMvT3xytCokxbAKp4?=
 =?us-ascii?q?S3cDUMxZ863RDQceaHfJKN4h/7UeaRJip3i2x9dbKkghay7VCgyurhVsmoyF?=
 =?us-ascii?q?pKrjRKkt3Ltn0Vyxzc8NKHSvpg/ke6wzqPywDS5f1EIUAzj6bbLYIuwqUsmZ?=
 =?us-ascii?q?YJtETDHyv2lF33jK+QaEok5vCl5/nob7jpvJORN5J4hhvgPqkhhMCzG/k0Ph?=
 =?us-ascii?q?ALX2eB+OS80LPj/Vf+QLVPlvA2ibTWsIvBKMQHpq+2Hw9V0oE55xa5FDepys?=
 =?us-ascii?q?4UnXYALFJbYB6HlZTmO0nSIPDkCveym0ijny1wx//YPrzsGY7NIWTDkLj7YL?=
 =?us-ascii?q?Z95UpcxxQpzdxG+51bEKsNL+70Wk/0rNbYFAM2MxSow+b7D9VwzoceWWOJAq?=
 =?us-ascii?q?+EP6LeqESI6fwzLOmRfo8VuSr9Kvg86/7rin82hEIdfa230pYMdnC4EeppI1?=
 =?us-ascii?q?+DbXrvnNgBC2EKsRQ6TODwj12CSzFTbW6oX60g/jE7FJ6mDYDbS4CpgbyB2j?=
 =?us-ascii?q?q7H5JPamBFFF+MC3HoeJuAW/oXdiKSLdFukiYeWbiiVYAhzxeuuxH+y7Z9Ke?=
 =?us-ascii?q?rU4CIYv4r51Ndp/+3TiQ0y9TtsAsSFyW6NUmV0k3gQRzAswaB/pVVxylKE0a?=
 =?us-ascii?q?h/mfxXC8Zf6O9OUgc/LZTc1fB1C8juWgLdedeEUEuoTNK6DDwvS9w92sIBY0?=
 =?us-ascii?q?dmG9q+kxDDxDGqDqQRl7yKH5w07rnc02LtK8pg0XrG07Mhj1Y+SMtVKWKmnr?=
 =?us-ascii?q?J/9xTUB4PRkUWZkKaqdaIG0C7P82eDzXCBvEdDUAFuV6XIRmwQaVHQrdT+4E?=
 =?us-ascii?q?PCTqOhBq4jMgdb1cGCLa5KYMXzjVpaXPfjJMjeY2WplmezGxmH2KiMY5bte2?=
 =?us-ascii?q?Ua3yXQE1QLkwAJ/XaBMAg+Bzqho2fEADxpD1LvbFvm8fNip3OjUk800waKYl?=
 =?us-ascii?q?V517Wr/B4ViuGcS/IV3r4duycutS90HFCj0NLSENeAphNtfKFbYdMj/lhLz3?=
 =?us-ascii?q?nZuBZ+Ppy9NaBtnEQScwJpsE/01RV3Ep1KkdI2o3My0ApyNaWY3UtDdzOd2p?=
 =?us-ascii?q?DwIKfXKmjp/B20ba7ZwFTe38iX+qsV7/Q4sVrj70mVER8J+m5qwpFu2HuV+5?=
 =?us-ascii?q?vOARBaBZn4SUsm3wNxp7jHbC0w/cbf3DtnNqzi9nfm4PdhUO8kzAuwOsxSO7?=
 =?us-ascii?q?6eFRPjVsgdC9WqJcQ0lFWzKBEJJuZf8OgzJczwM7Oi+4qOdLJknTS7nSFE7Z?=
 =?us-ascii?q?p730ak6SVxUKjL0owDzvXe2RGIAXO0tF68tojSnodeaHlGBmOizQD8DZNVI6?=
 =?us-ascii?q?h1epwGT2ypJpvzju5Tz7rsXWNIvAq4ClcH3tK5UQaDZFz6mwtL3AIYpmLx3W?=
 =?us-ascii?q?Py9BlduBJsoquE1zHV2MzmdQEbISgTHS9ll1imadyPqvkxfw2kbhMiiQC+zU?=
 =?us-ascii?q?L73LRA4vwmaW7JThEMNwrxL2cqcKywv7yZbsgHvJEvsSMRUuO8aFaBR7jVqB?=
 =?us-ascii?q?Ic1CXiFGJagjs8cmfu8rb0kgcyo2WaLz4nr3fUYsp3whT379zGQvtQwz9AQz?=
 =?us-ascii?q?N3332fOlWgJMSutfWdkZvK+rSmWmSuS5xVNCrm14WNsAO6oGltHxD5hPmwh8?=
 =?us-ascii?q?fuVw43ly3jgZ0idyzNoQ20R47xzaWhebZle05yHl7nw8xzH4x/1Iwqi8dD92?=
 =?us-ascii?q?Idg8Cu4XcfkWr1ee5e0Kb6YWtFESUH2PbJ8QPl3wtlNXvPyIXnACbOivB9bs?=
 =?us-ascii?q?W3NztFkhk26NpHXeLNtuRJ?=
X-IPAS-Result: =?us-ascii?q?A2C1BQB5vvla/wHyM5BcGwEBAQEDAQEBCQEBAYMYK4FcK?=
 =?us-ascii?q?INylHNFAQEBAQEBBn8pdRqVKjYBhEACgxEhNxUBAgEBAQEBAQIBayiCNSQBg?=
 =?us-ascii?q?k4BAQEBAyMEYgsRAwECAQICJgICTwgGAQwGAgEBgl9AgXQNqwiBaTODeAEBX?=
 =?us-ascii?q?oNngieBCYccgQyBB4EPI4IzNYdzglQChziEYIweCY5LBoxvkggyIoFSKwgCG?=
 =?us-ascii?q?AghD4J+kBgBUSMwegEBj20BAQ?=
Subject: Re: [PATCH 20/23] LSM: Move common usercopy into
To: Casey Schaufler <casey@schaufler-ca.com>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        SE Linux <selinux@tycho.nsa.gov>,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>
References: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
 <cb3455a2-b957-8a9a-f056-35f97fe51e71@schaufler-ca.com>
 <a9e6b33b-3d17-2535-5798-bc092e8559c3@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <992325e2-0f53-0b3d-ddd2-f4f8ba7ccf89@tycho.nsa.gov>
Date: Mon, 14 May 2018 12:53:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <a9e6b33b-3d17-2535-5798-bc092e8559c3@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/14/2018 11:12 AM, Stephen Smalley wrote:
> On 05/10/2018 08:55 PM, Casey Schaufler wrote:
>> From: Casey Schaufler <casey@schaufler-ca.com>
>> Date: Thu, 10 May 2018 15:54:25 -0700
>> Subject: [PATCH 20/23] LSM: Move common usercopy into
>>  security_getpeersec_stream
>>
>> The modules implementing hook for getpeersec_stream
>> don't need to be duplicating the copy-to-user checks.
>> Moving the user copy part into the infrastructure makes
>> the security module code simpler and reduces the places
>> where user copy code may go awry.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/lsm_hooks.h  | 10 ++++------
>>  include/linux/security.h   |  6 ++++--
>>  security/apparmor/lsm.c    | 28 ++++++++++------------------
>>  security/security.c        | 17 +++++++++++++++--
>>  security/selinux/hooks.c   | 22 +++++++---------------
>>  security/smack/smack_lsm.c | 19 ++++++++-----------
>>  6 files changed, 48 insertions(+), 54 deletions(-)
>>
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index 81504623afb4..84bc9ec01931 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -841,9 +841,8 @@
>>   *	SO_GETPEERSEC.  For tcp sockets this can be meaningful if the
>>   *	socket is associated with an ipsec SA.
>>   *	@sock is the local socket.
>> - *	@optval userspace memory where the security state is to be copied.
>> - *	@optlen userspace int where the module should copy the actual length
>> - *	of the security state.
>> + *	@optval the security state.
>> + *	@optlen the actual length of the security state.
>>   *	@len as input is the maximum length to copy to userspace provided
>>   *	by the caller.
>>   *	Return 0 if all is well, otherwise, typical getsockopt return
>> @@ -1674,9 +1673,8 @@ union security_list_options {
>>  	int (*socket_setsockopt)(struct socket *sock, int level, int optname);
>>  	int (*socket_shutdown)(struct socket *sock, int how);
>>  	int (*socket_sock_rcv_skb)(struct sock *sk, struct sk_buff *skb);
>> -	int (*socket_getpeersec_stream)(struct socket *sock,
>> -					char __user *optval,
>> -					int __user *optlen, unsigned int len);
>> +	int (*socket_getpeersec_stream)(struct socket *sock, char **optval,
>> +					int *optlen, unsigned int len);
>>  	int (*socket_getpeersec_dgram)(struct socket *sock,
>>  					struct sk_buff *skb,
>>  					struct secids *secid);
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index ab70064c283f..712d138e0148 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -1369,8 +1369,10 @@ static inline int security_sock_rcv_skb(struct sock *sk,
>>  	return 0;
>>  }
>>  
>> -static inline int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
>> -						    int __user *optlen, unsigned len)
>> +static inline int security_socket_getpeersec_stream(struct socket *sock,
>> +						    char __user *optval,
>> +						    int __user *optlen,
>> +						    unsigned int len)
>>  {
>>  	return -ENOPROTOOPT;
>>  }
>> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
>> index 90453dbb4fac..7444cfa689b3 100644
>> --- a/security/apparmor/lsm.c
>> +++ b/security/apparmor/lsm.c
>> @@ -1017,10 +1017,8 @@ static struct aa_label *sk_peer_label(struct sock *sk)
>>   *
>>   * Note: for tcp only valid if using ipsec or cipso on lan
>>   */
>> -static int apparmor_socket_getpeersec_stream(struct socket *sock,
>> -					     char __user *optval,
>> -					     int __user *optlen,
>> -					     unsigned int len)
>> +static int apparmor_socket_getpeersec_stream(struct socket *sock, char **optval,
>> +					     int *optlen, unsigned int len)
>>  {
>>  	char *name;
>>  	int slen, error = 0;
>> @@ -1037,22 +1035,16 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
>>  				 FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
>>  				 FLAG_HIDDEN_UNCONFINED, GFP_KERNEL);
>>  	/* don't include terminating \0 in slen, it breaks some apps */
>> -	if (slen < 0) {
>> +	if (slen < 0)
>>  		error = -ENOMEM;
>> -	} else {
>> -		if (slen > len) {
>> -			error = -ERANGE;
>> -		} else if (copy_to_user(optval, name, slen)) {
>> -			error = -EFAULT;
>> -			goto out;
>> -		}
>> -		if (put_user(slen, optlen))
>> -			error = -EFAULT;
>> -out:
>> -		kfree(name);
>> -
>> +	else if (slen > len)
>> +		error = -ERANGE;
>> +	else {
>> +		*optlen = slen;
>> +		*optval = name;
>>  	}
>> -
>> +	if (error)
>> +		kfree(name);
>>  done:
>>  	end_current_label_crit_section(label);
>>  
>> diff --git a/security/security.c b/security/security.c
>> index cbe1a497ec5a..6144ff52d862 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -1924,8 +1924,21 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
>>  int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
>>  				      int __user *optlen, unsigned len)
>>  {
>> -	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
>> -				optval, optlen, len);
>> +	char *tval = NULL;
>> +	u32 tlen;
>> +	int rc;
>> +
>> +	rc = call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
>> +			   &tval, &tlen, len);
>> +	if (rc == 0) {
>> +		tlen = strlen(tval) + 1;
> 
> Why are you recomputing tlen here from what the module provided, and further presuming it must be nul-terminated?

Also, at least for SELinux, we copy out the length even when returning ERANGE, and libselinux uses that to realloc the buffer and try again.

> 
>> +		if (put_user(tlen, optlen))
>> +			rc = -EFAULT;
>> +		else if (copy_to_user(optval, tval, tlen))
>> +			rc = -EFAULT;
>> +		kfree(tval);
>> +	}
>> +	return rc;
>>  }
>>  
>>  int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 81f104d9e85e..9520341daa78 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -4955,10 +4955,8 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>>  	return err;
>>  }
>>  
>> -static int selinux_socket_getpeersec_stream(struct socket *sock,
>> -					    __user char *optval,
>> -					    __user int *optlen,
>> -					    unsigned int len)
>> +static int selinux_socket_getpeersec_stream(struct socket *sock, char **optval,
>> +					    int *optlen, unsigned int len)
>>  {
>>  	int err = 0;
>>  	char *scontext;
>> @@ -4979,18 +4977,12 @@ static int selinux_socket_getpeersec_stream(struct socket *sock,
>>  		return err;
>>  
>>  	if (scontext_len > len) {
>> -		err = -ERANGE;
>> -		goto out_len;
>> +		kfree(scontext);
>> +		return -ERANGE;
>>  	}
>> -
>> -	if (copy_to_user(optval, scontext, scontext_len))
>> -		err = -EFAULT;
>> -
>> -out_len:
>> -	if (put_user(scontext_len, optlen))
>> -		err = -EFAULT;
>> -	kfree(scontext);
>> -	return err;
>> +	*optval = scontext;
>> +	*optlen = scontext_len;
>> +	return 0;
>>  }
>>  
>>  static int selinux_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, struct secids *secid)
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>> index 660a55ee8a57..12b00aac0c94 100644
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
>> @@ -3878,14 +3878,12 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>>   *
>>   * returns zero on success, an error code otherwise
>>   */
>> -static int smack_socket_getpeersec_stream(struct socket *sock,
>> -					  char __user *optval,
>> -					  int __user *optlen, unsigned len)
>> +static int smack_socket_getpeersec_stream(struct socket *sock, char **optval,
>> +					  int *optlen, unsigned int len)
>>  {
>>  	struct socket_smack *ssp;
>>  	char *rcp = "";
>>  	int slen = 1;
>> -	int rc = 0;
>>  
>>  	ssp = smack_sock(sock->sk);
>>  	if (ssp->smk_packet != NULL) {
>> @@ -3894,14 +3892,13 @@ static int smack_socket_getpeersec_stream(struct socket *sock,
>>  	}
>>  
>>  	if (slen > len)
>> -		rc = -ERANGE;
>> -	else if (copy_to_user(optval, rcp, slen) != 0)
>> -		rc = -EFAULT;
>> -
>> -	if (put_user(slen, optlen) != 0)
>> -		rc = -EFAULT;
>> +		return -ERANGE;
>>  
>> -	return rc;
>> +	*optval = kstrdup(rcp, GFP_ATOMIC);
>> +	if (*optval == NULL)
>> +		return -ENOMEM;
>> +	*optlen = slen;
>> +	return 0;
>>  }
>>  
>>  
>>
> 
> 

