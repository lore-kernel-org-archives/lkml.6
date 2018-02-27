Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1459126-1519735273-2-4225308866827717881
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519735272; b=rUPE+Zw5JTO7iFWzjOIKuPKYOS0k/9elCy7nGczWCU+HnBv
    jLNo0AslhQzhIAOOL8g9Lvc0p6Mth2bWoYqHjoF+WdWhcBsVhtnloPZ/C4v9km0z
    /1ACLgTPoER6JPbEf5NaZ2e2zzj4PZeqGirdZeArbE50JSFU4fMEdtV/zKpD6YGR
    pNw4DFD9c+CnrUHOIjx55SN53Z+vJbYSrwB91X2D/bQF1VrNrVW7yvNg03yDMudC
    dFhi2ZKHJqX4uCt3wC6ZqtKSqFnw12C2ALiOsCw/4YmD+uQmqaAHqB2gXzcE79re
    Dl6K18wocYfW9W7qGnIbGX+zN/GGfwjRMnW7j3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519735272; bh=/yC15tS3dA96E8OdhARM/pW2Gy
    Q0/IqW+ER4NwPuwvM=; b=XHWUGIBJMzWJzT+CqPhnYb/IQxNbEnvBvpBd32uTPr
    TcAaBNYzqUiH1kibWo4d//+2gy8GiqXFWio5kPTJ7viOy06le45o2/q6fzAJddZs
    evzZIXNBHgiNgSCX8WNzdXOBefa96BGh2GJ+u4IUWk571V8E12ItlMBYnP46H7ZY
    NThNaAqhmVxPX5Gao0Q/N3UNIiFO6B24+PkoS16FTRW9EcfYaF0maRdRkpKWAjGb
    4yhCw9njLy4x33V00ADuSZdozAaUUxaiFSvQ+/O3d87IVt+Pa/LD0lqs6cc7A20R
    E7wRPmcNyUI7cKyNAhSFDPP0MImw1tTmDcawxHqLaGUw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753049AbeB0Mkx (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 07:40:53 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38100 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752994AbeB0Mkv (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 07:40:51 -0500
Date: Tue, 27 Feb 2018 13:40:50 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Cc: Thomas Backlund <tmb@mageia.org>,
        Steve French <smfrench@gmail.com>,
        =?iso-8859-1?Q?Aur=E9lien?= Aptel <aaptel@suse.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        lsahlber@redhat.com, pshilov@microsoft.com,
        linux-cifs@vger.kernel.org
Subject: Re: [PATCH 4.13 28/43] SMB3: Validate negotiate request must always
 be signed
Message-ID: <20180227124050.GB31888@kroah.com>
References: <20171031095530.520746935@linuxfoundation.org>
 <20171031095531.633196173@linuxfoundation.org>
 <97340c9a-0ea2-0d3d-cf26-58c799d76cae@mageia.org>
 <20171101151803.GB31285@kroah.com>
 <4ba67095-4075-688f-d3fb-157847aee4d9@csail.mit.edu>
 <28ffc363-5140-5685-d288-6e3dc07c6369@csail.mit.edu>
 <20180227085428.GA16879@kroah.com>
 <b20cbd94-ce9b-cb2c-dc95-a6821376823f@csail.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b20cbd94-ce9b-cb2c-dc95-a6821376823f@csail.mit.edu>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 01:22:31AM -0800, Srivatsa S. Bhat wrote:
> On 2/27/18 12:54 AM, Greg Kroah-Hartman wrote:
> > On Mon, Feb 26, 2018 at 07:44:28PM -0800, Srivatsa S. Bhat wrote:
> >> On 1/3/18 6:15 PM, Srivatsa S. Bhat wrote:
> >>> On 11/1/17 8:18 AM, Greg Kroah-Hartman wrote:
> >>>> On Tue, Oct 31, 2017 at 03:02:11PM +0200, Thomas Backlund wrote:
> >>>>> Den 31.10.2017 kl. 11:55, skrev Greg Kroah-Hartman:
> >>>>>> 4.13-stable review patch.  If anyone has any objections, please let me know.
> >>>>>>
> >>>>>> ------------------
> >>>>>>
> >>>>>> From: Steve French <smfrench@gmail.com>
> >>>>>>
> >>>>>> commit 4587eee04e2ac7ac3ac9fa2bc164fb6e548f99cd upstream.
> >>>>>>
> >>>>>> According to MS-SMB2 3.2.55 validate_negotiate request must
> >>>>>> always be signed. Some Windows can fail the request if you send it unsigned
> >>>>>>
> >>>>>> See kernel bugzilla bug 197311
> >>>>>>
> >>>>>> Acked-by: Ronnie Sahlberg <lsahlber.redhat.com>
> >>>>>> Signed-off-by: Steve French <smfrench@gmail.com>
> >>>>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>>>>>
> >>>>>> ---
> >>>>>>   fs/cifs/smb2pdu.c |    3 +++
> >>>>>>   1 file changed, 3 insertions(+)
> >>>>>>
> >>>>>> --- a/fs/cifs/smb2pdu.c
> >>>>>> +++ b/fs/cifs/smb2pdu.c
> >>>>>> @@ -1963,6 +1963,9 @@ SMB2_ioctl(const unsigned int xid, struc
> >>>>>>   	} else
> >>>>>>   		iov[0].iov_len = get_rfc1002_length(req) + 4;
> >>>>>> +	/* validate negotiate request must be signed - see MS-SMB2 3.2.5.5 */
> >>>>>> +	if (opcode == FSCTL_VALIDATE_NEGOTIATE_INFO)
> >>>>>> +		req->hdr.sync_hdr.Flags |= SMB2_FLAGS_SIGNED;
> >>>>>>   	rc = SendReceive2(xid, ses, iov, n_iov, &resp_buftype, flags, &rsp_iov);
> >>>>>>   	cifs_small_buf_release(req);
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>
> >>>>> This one needs to be backported to all stable kernels as the commit that
> >>>>> introduced the regression:
> >>>>> '
> >>>>> 0603c96f3af50e2f9299fa410c224ab1d465e0f9
> >>>>> SMB: Validate negotiate (to protect against downgrade) even if signing off
> >>>>>
> >>>>> is backported in stable trees as of: 4.9.53, 4.4.90, 3.18.73
> >>>>
> >>>> Oh wait, it breaks the builds on older kernels, that's why I didn't
> >>>> apply it :)
> >>>>
> >>>> Can you provide me with a working backport?
> >>>>
> >>>
> >>> Hi Steve,
> >>>
> >>> Is there a version of this fix available for stable kernels?
> >>>
> >>
> >> Hi Greg,
> >>
> >> Mounting SMB3 shares continues to fail for me on 4.4.118 and 4.9.84
> >> due to the issues that I have described in detail on this mail thread.
> >>
> >> Since there is no apparent fix for this bug on stable kernels, could
> >> you please consider reverting the original commit that caused this
> >> regression?
> >>
> >> That commit was intended to enhance security, which is probably why it
> >> was backported to stable kernels in the first place; but instead it
> >> ends up breaking basic functionality itself (mounting). So in the
> >> absence of a proper fix, I don't see much of an option but to revert
> >> that commit.
> >>
> >> So, please consider reverting the following:
> >>
> >> commit 02ef29f9cbb616bf419 "SMB: Validate negotiate (to protect
> >> against downgrade) even if signing off" on 4.4.118
> >>
> >> commit 0e1b85a41a25ac888fb "SMB: Validate negotiate (to protect
> >> against downgrade) even if signing off" on 4.9.84
> >>
> >> They correspond to commit 0603c96f3af50e2f9299fa410c224ab1d465e0f9
> >> upstream. Both these patches should revert cleanly. 
> > 
> > Do you still have this same problem on 4.14 and 4.15?  If so, the issue
> > needs to get fixed there, not papered-over by reverting these old
> > changes, as you will hit the issue again in the future when you update
> > to a newer kernel version.
> > 
> 
> 4.14 and 4.15 work great! (I had mentioned this is in my original bug
> report but forgot to summarize it here, sorry).


Then what is the bugfix that should be applied here in order to keep
things working with these patches applied?

thanks,

greg k-h
