Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-189899-1524051592-2-16285469323004761696
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES roenca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524051591; b=eYo9vglGLo3YLksEGe2R11+NE5sEsHUVOsE0c/M/3yoVlVKJJX
    ZhIa14bcL5RLR0TyP8m0VdYnmkNcHFd5f6THex/gjTEsA7f3Bpg46dwK0TMamDlT
    7vh7KNzVMQcG5y1JjyTJ/8ZdcXNYB7++COXEjaPdh1QkaQ8YA+Z3t1xR7IXX7YgO
    WfjOghzrdQEaf8/WSL3Mc0nlhHNjcQEMrFYfrIlaffHkq2fPc85ovet9LYSU/mq4
    +4qar15B1R1GzLA/H8kG6H7Zca1hVxFm96cv+dAM98vXiSgdgLDIAUIZrzom3F1n
    gtlKvJ7kUZUjPVWAShWFEaZhC5EeQ4eSQ5PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524051591;
    bh=DjjmKw7AjtF6vtMGvqOk8nQeq13Lfzte2LXczCEybeE=; b=l6e2kDAuc35q
    4jglTISZiE9tprZMnGk8pUQGoiazcz86RFGdTeNja29HbYx3IfYdTbVRNvH6RmeV
    fTzyGfJI86v/s/R7OKeI9kkx0s8Gs+FFmks46aFjnLWhhVOz/UTwZB8dSzXxqPm9
    MDwRIg9bG4Vzi0RxqXGV7tOcSELSfPtR7xFB6oB0HQJvVCLoq/g0R7AsCzaYK1tY
    EHblyuw6SiAAiKSWqWvwBh8k8UeZfrThnyRfRVSneANcRflzFcOX9LuvIAyjNcEV
    lavX6j1TZx4X6O7I1uFMX+xOi3YU0wdSgI8dX+v+itHtCnnhhId55I6hUDY4xdyx
    K9hUZ5R2aw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=talpey.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=talpey.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=talpey.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=talpey.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFzfT0iMDX8eInoC5o/yYQ5kOoP/JxvJ+eivXSBXTwYLdEXquy5LvsBAjtT7hki4QPVg6bD0ABzkzBjVo6s0MVOukNm0Uk3t1t9i8OnfRmbofFGGbAlK
    0Pi/JisUEQnbO+qTrHbjqitImHYnlTnlP3hV0gDpNtwkbDXsrZTIjH1R+D8LKdupB0uRsTaCpBz1ZFou4ZJxTeLAPcV6qPErvcnVBz0dOicuIm9tCZHcDCz+
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=h6HYFqFZYC0A:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=yMhMjlubAAAA:8 a=CbDCq_QkAAAA:8 a=VwQbUJbxAAAA:8
    a=snWDK6GwBpQLrudeng0A:9 a=QEXdDO2ut3YA:10 a=1qrBK16LubpBFNPVNq2M:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753353AbeDRLju (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 07:39:50 -0400
Received: from p3plsmtpa11-04.prod.phx3.secureserver.net ([68.178.252.105]:44071
        "EHLO p3plsmtpa11-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753114AbeDRLjt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Apr 2018 07:39:49 -0400
Subject: Re: [Patch v3 2/6] cifs: Allocate validate negotiation request
 through kmalloc
To: longli@microsoft.com, Steve French <sfrench@samba.org>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20180418003358.25098-1-longli@linuxonhyperv.com>
From: Tom Talpey <tom@talpey.com>
Message-ID: <d7e569b6-d268-b8c1-e91d-d6dc0e7cdfc2@talpey.com>
Date: Wed, 18 Apr 2018 07:32:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180418003358.25098-1-longli@linuxonhyperv.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBmV5B3aAsOXZrRHPrMzft/M48KtXAV3qpwrYEGY4VDEdq1tGT9d2Uh7sWPFLeTeoJDwxAHs6xYxSuVU49AyKthlTwt7fMR3yWfurgqv6LDb5aBVeEUp
 8XDfwBLjScHfh7LVe0MV8baJ1D273JtGAuZF0S/uYHDGxsvxYnA4Xs6RwHvQzAaBkVdZrzR2G+bTHPVYGqzUC51+JU/JmrW/b3TXpU2ZdFRWU0KCSW9W0cFF
 vzBh5A3VDrTzOr/8FEMrpB4qRF4w2nm/Y9m7u4z+iu5DaTsbOJ6buEusZJWeC82zV0d1idENY4uMERbpDU+8T3oZaI708M9Yj0zT91B4I/gqcbK+Dv5Kj5ZA
 jUOuS/7saKjHd3tEEEXpXUJ4BS2YYHuM/L2+t52f1W3o8q5hUTU=
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Two comments.

On 4/17/2018 8:33 PM, Long Li wrote:
> From: Long Li <longli@microsoft.com>
> 
> The data buffer allocated on the stack can't be DMA'ed, and hence can't send
> through RDMA via SMB Direct.

This comment is confusing. Any registered memory can be DMA'd, need to
state the reason for the choice here more clearly.

> 
> Fix this by allocating the request on the heap in smb3_validate_negotiate.
> 
> Changes in v2:
> Removed duplicated code on freeing buffers on function exit.
> (Thanks to Parav Pandit <parav@mellanox.com>)
> Fixed typo in the patch title.
> 
> Changes in v3:
> Added "Fixes" to the patch.
> Changed sizeof() to use *pointer in place of struct.
> 
> Fixes: ff1c038addc4 ("Check SMB3 dialects against downgrade attacks")
> Signed-off-by: Long Li <longli@microsoft.com>
> Cc: stable@vger.kernel.org
> ---
>   fs/cifs/smb2pdu.c | 59 ++++++++++++++++++++++++++++++-------------------------
>   1 file changed, 32 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
> index 0f044c4..5582a02 100644
> --- a/fs/cifs/smb2pdu.c
> +++ b/fs/cifs/smb2pdu.c
> @@ -729,8 +729,8 @@ SMB2_negotiate(const unsigned int xid, struct cifs_ses *ses)
>   
>   int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
>   {
> -	int rc = 0;
> -	struct validate_negotiate_info_req vneg_inbuf;
> +	int ret, rc = -EIO;
> +	struct validate_negotiate_info_req *pneg_inbuf;
>   	struct validate_negotiate_info_rsp *pneg_rsp = NULL;
>   	u32 rsplen;
>   	u32 inbuflen; /* max of 4 dialects */
> @@ -741,6 +741,9 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
>   	if (tcon->ses->server->rdma)
>   		return 0;
>   #endif
> +	pneg_inbuf = kmalloc(sizeof(*pneg_inbuf), GFP_KERNEL);
> +	if (!pneg_inbuf)
> +		return -ENOMEM;

Why is this a nonblocking allocation? It would seem more robust to
use GFP_NOFS here.

Tom.

>   
>   	/* In SMB3.11 preauth integrity supersedes validate negotiate */
>   	if (tcon->ses->server->dialect == SMB311_PROT_ID)
> @@ -764,63 +767,63 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
>   	if (tcon->ses->session_flags & SMB2_SESSION_FLAG_IS_NULL)
>   		cifs_dbg(VFS, "Unexpected null user (anonymous) auth flag sent by server\n");
>   
> -	vneg_inbuf.Capabilities =
> +	pneg_inbuf->Capabilities =
>   			cpu_to_le32(tcon->ses->server->vals->req_capabilities);
> -	memcpy(vneg_inbuf.Guid, tcon->ses->server->client_guid,
> +	memcpy(pneg_inbuf->Guid, tcon->ses->server->client_guid,
>   					SMB2_CLIENT_GUID_SIZE);
>   
>   	if (tcon->ses->sign)
> -		vneg_inbuf.SecurityMode =
> +		pneg_inbuf->SecurityMode =
>   			cpu_to_le16(SMB2_NEGOTIATE_SIGNING_REQUIRED);
>   	else if (global_secflags & CIFSSEC_MAY_SIGN)
> -		vneg_inbuf.SecurityMode =
> +		pneg_inbuf->SecurityMode =
>   			cpu_to_le16(SMB2_NEGOTIATE_SIGNING_ENABLED);
>   	else
> -		vneg_inbuf.SecurityMode = 0;
> +		pneg_inbuf->SecurityMode = 0;
>   
>   
>   	if (strcmp(tcon->ses->server->vals->version_string,
>   		SMB3ANY_VERSION_STRING) == 0) {
> -		vneg_inbuf.Dialects[0] = cpu_to_le16(SMB30_PROT_ID);
> -		vneg_inbuf.Dialects[1] = cpu_to_le16(SMB302_PROT_ID);
> -		vneg_inbuf.DialectCount = cpu_to_le16(2);
> +		pneg_inbuf->Dialects[0] = cpu_to_le16(SMB30_PROT_ID);
> +		pneg_inbuf->Dialects[1] = cpu_to_le16(SMB302_PROT_ID);
> +		pneg_inbuf->DialectCount = cpu_to_le16(2);
>   		/* structure is big enough for 3 dialects, sending only 2 */
>   		inbuflen = sizeof(struct validate_negotiate_info_req) - 2;
>   	} else if (strcmp(tcon->ses->server->vals->version_string,
>   		SMBDEFAULT_VERSION_STRING) == 0) {
> -		vneg_inbuf.Dialects[0] = cpu_to_le16(SMB21_PROT_ID);
> -		vneg_inbuf.Dialects[1] = cpu_to_le16(SMB30_PROT_ID);
> -		vneg_inbuf.Dialects[2] = cpu_to_le16(SMB302_PROT_ID);
> -		vneg_inbuf.DialectCount = cpu_to_le16(3);
> +		pneg_inbuf->Dialects[0] = cpu_to_le16(SMB21_PROT_ID);
> +		pneg_inbuf->Dialects[1] = cpu_to_le16(SMB30_PROT_ID);
> +		pneg_inbuf->Dialects[2] = cpu_to_le16(SMB302_PROT_ID);
> +		pneg_inbuf->DialectCount = cpu_to_le16(3);
>   		/* structure is big enough for 3 dialects */
>   		inbuflen = sizeof(struct validate_negotiate_info_req);
>   	} else {
>   		/* otherwise specific dialect was requested */
> -		vneg_inbuf.Dialects[0] =
> +		pneg_inbuf->Dialects[0] =
>   			cpu_to_le16(tcon->ses->server->vals->protocol_id);
> -		vneg_inbuf.DialectCount = cpu_to_le16(1);
> +		pneg_inbuf->DialectCount = cpu_to_le16(1);
>   		/* structure is big enough for 3 dialects, sending only 1 */
>   		inbuflen = sizeof(struct validate_negotiate_info_req) - 4;
>   	}
>   
> -	rc = SMB2_ioctl(xid, tcon, NO_FILE_ID, NO_FILE_ID,
> +	ret = SMB2_ioctl(xid, tcon, NO_FILE_ID, NO_FILE_ID,
>   		FSCTL_VALIDATE_NEGOTIATE_INFO, true /* is_fsctl */,
> -		(char *)&vneg_inbuf, sizeof(struct validate_negotiate_info_req),
> +		(char *)pneg_inbuf, sizeof(*pneg_inbuf),
>   		(char **)&pneg_rsp, &rsplen);
>   
> -	if (rc != 0) {
> -		cifs_dbg(VFS, "validate protocol negotiate failed: %d\n", rc);
> -		return -EIO;
> +	if (ret) {
> +		cifs_dbg(VFS, "validate protocol negotiate failed: %d\n", ret);
> +		goto out_free_inbuf;
>   	}
>   
> -	if (rsplen != sizeof(struct validate_negotiate_info_rsp)) {
> +	if (rsplen != sizeof(*pneg_rsp)) {
>   		cifs_dbg(VFS, "invalid protocol negotiate response size: %d\n",
>   			 rsplen);
>   
>   		/* relax check since Mac returns max bufsize allowed on ioctl */
>   		if ((rsplen > CIFSMaxBufSize)
>   		     || (rsplen < sizeof(struct validate_negotiate_info_rsp)))
> -			goto err_rsp_free;
> +			goto out_free_rsp;
>   	}
>   
>   	/* check validate negotiate info response matches what we got earlier */
> @@ -838,14 +841,16 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
>   
>   	/* validate negotiate successful */
>   	cifs_dbg(FYI, "validate negotiate info successful\n");
> -	kfree(pneg_rsp);
> -	return 0;
> +	rc = 0;
> +	goto out_free_rsp;
>   
>   vneg_out:
>   	cifs_dbg(VFS, "protocol revalidation - security settings mismatch\n");
> -err_rsp_free:
> +out_free_rsp:
>   	kfree(pneg_rsp);
> -	return -EIO;
> +out_free_inbuf:
> +	kfree(pneg_inbuf);
> +	return rc;
>   }
>   
>   enum securityEnum
> 
