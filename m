Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-379639-1519703089-2-16344829572818079926
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519703088; b=gzPOgAbEP0M2bN7bDWuonWO17QEC8sKQDX5OuTZqpKvnErr
    xDQHV35wyF5WQbkwwTvep0bhg5QlJVVYWbE5Di1ThArZnPY//5H+SXgCAEPxObRq
    4BlSrKw75ZeTt9m9zX7Ic9lApwK6aEl2lJ9wP0HM4F91BwVYjQHYfvT8p0RvLpk/
    epuEUVgC/pSck4TFrnfdR+OJ9j+YNdlA2n0P8TwZnlJHZ0xaB5lWIKrQxxweqCs7
    fpc08TAM+YlVCQvrPtbNPpVw7PQ3geeX+1f97Us6BGT1/IQJUQ6FdWRXFZa+5yud
    gtexpt+QTa2kfL0q7QH0ZYeHJ3EWc7EPOqfnTzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:references:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519703088; bh=+qEPEbhNhVPDl7lF4OrOwakYjEqaeUfUkffT9kZ6xkY=; b=R
    iinEHfAfyJRQ5yGbkpUNSPl7oAtTyLFlhEaISMH03nkhM1R7tskk33nPP58VDpi4
    7qCWBAjUG9dB/PMEuPkXTgDgyH4u5WB14Y1FFHyAzw/P2P3GafnN285nyjZHOEym
    o5W6Y9f94FyN2llIsyad1pT49LV4iJHBs9ilYMJcX779Mxyc1PGV1Yvr5FkPOt3y
    wfuJKfOR4akvjfuDMRUd44A6Jb/fqBr50SL3t/cwdEVI3g3dvvPm33S/tkqxO+Xu
    F3gqFSXjdT6vScg464swOs6muDRF0JYPCKk9MekLBVOa+plosi8/uibHYyLUH8fE
    DtetlC5uSzJpojScOfF7A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=csail.mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=csail.mit.edu header.result=pass header_org.domain=mit.edu header_org.result=pass header_is_org_domain=no
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=csail.mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=csail.mit.edu header.result=pass header_org.domain=mit.edu header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbeB0Doq (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 22:44:46 -0500
Received: from outgoing-stata.csail.mit.edu ([128.30.2.210]:34177 "EHLO
        outgoing-stata.csail.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751514AbeB0Dop (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 22:44:45 -0500
Subject: Re: [PATCH 4.13 28/43] SMB3: Validate negotiate request must always
 be signed
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Backlund <tmb@mageia.org>,
        Steve French <smfrench@gmail.com>,
        =?UTF-8?Q?Aur=c3=a9lien_Aptel?= <aaptel@suse.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        lsahlber@redhat.com, pshilov@microsoft.com,
        linux-cifs@vger.kernel.org
References: <20171031095530.520746935@linuxfoundation.org>
 <20171031095531.633196173@linuxfoundation.org>
 <97340c9a-0ea2-0d3d-cf26-58c799d76cae@mageia.org>
 <20171101151803.GB31285@kroah.com>
 <4ba67095-4075-688f-d3fb-157847aee4d9@csail.mit.edu>
Message-ID: <28ffc363-5140-5685-d288-6e3dc07c6369@csail.mit.edu>
Date: Mon, 26 Feb 2018 19:44:28 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4ba67095-4075-688f-d3fb-157847aee4d9@csail.mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 1/3/18 6:15 PM, Srivatsa S. Bhat wrote:
> On 11/1/17 8:18 AM, Greg Kroah-Hartman wrote:
>> On Tue, Oct 31, 2017 at 03:02:11PM +0200, Thomas Backlund wrote:
>>> Den 31.10.2017 kl. 11:55, skrev Greg Kroah-Hartman:
>>>> 4.13-stable review patch.  If anyone has any objections, please let me know.
>>>>
>>>> ------------------
>>>>
>>>> From: Steve French <smfrench@gmail.com>
>>>>
>>>> commit 4587eee04e2ac7ac3ac9fa2bc164fb6e548f99cd upstream.
>>>>
>>>> According to MS-SMB2 3.2.55 validate_negotiate request must
>>>> always be signed. Some Windows can fail the request if you send it unsigned
>>>>
>>>> See kernel bugzilla bug 197311
>>>>
>>>> Acked-by: Ronnie Sahlberg <lsahlber.redhat.com>
>>>> Signed-off-by: Steve French <smfrench@gmail.com>
>>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>
>>>> ---
>>>>   fs/cifs/smb2pdu.c |    3 +++
>>>>   1 file changed, 3 insertions(+)
>>>>
>>>> --- a/fs/cifs/smb2pdu.c
>>>> +++ b/fs/cifs/smb2pdu.c
>>>> @@ -1963,6 +1963,9 @@ SMB2_ioctl(const unsigned int xid, struc
>>>>   	} else
>>>>   		iov[0].iov_len = get_rfc1002_length(req) + 4;
>>>> +	/* validate negotiate request must be signed - see MS-SMB2 3.2.5.5 */
>>>> +	if (opcode == FSCTL_VALIDATE_NEGOTIATE_INFO)
>>>> +		req->hdr.sync_hdr.Flags |= SMB2_FLAGS_SIGNED;
>>>>   	rc = SendReceive2(xid, ses, iov, n_iov, &resp_buftype, flags, &rsp_iov);
>>>>   	cifs_small_buf_release(req);
>>>>
>>>>
>>>>
>>>
>>> This one needs to be backported to all stable kernels as the commit that
>>> introduced the regression:
>>> '
>>> 0603c96f3af50e2f9299fa410c224ab1d465e0f9
>>> SMB: Validate negotiate (to protect against downgrade) even if signing off
>>>
>>> is backported in stable trees as of: 4.9.53, 4.4.90, 3.18.73
>>
>> Oh wait, it breaks the builds on older kernels, that's why I didn't
>> apply it :)
>>
>> Can you provide me with a working backport?
>>
> 
> Hi Steve,
> 
> Is there a version of this fix available for stable kernels?
> 

Hi Greg,

Mounting SMB3 shares continues to fail for me on 4.4.118 and 4.9.84
due to the issues that I have described in detail on this mail thread.

Since there is no apparent fix for this bug on stable kernels, could
you please consider reverting the original commit that caused this
regression?

That commit was intended to enhance security, which is probably why it
was backported to stable kernels in the first place; but instead it
ends up breaking basic functionality itself (mounting). So in the
absence of a proper fix, I don't see much of an option but to revert
that commit.

So, please consider reverting the following:

commit 02ef29f9cbb616bf419 "SMB: Validate negotiate (to protect
against downgrade) even if signing off" on 4.4.118

commit 0e1b85a41a25ac888fb "SMB: Validate negotiate (to protect
against downgrade) even if signing off" on 4.9.84

They correspond to commit 0603c96f3af50e2f9299fa410c224ab1d465e0f9
upstream. Both these patches should revert cleanly. 

Thank you!

Regards,
Srivatsa
