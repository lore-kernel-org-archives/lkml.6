Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3571199-1526629691-2-8562795210019007953
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526629690; b=DstEGNiA42XsALqOh6iFbrYiYfk1FnX2eO+PgaV+6yNxWWuTAY
    C3Q3eRy1s6gqIM+B2W/XX6aUpHT+xogRwj+A/f/GCTt6p/QI1/LRJmiFnQBfHc7u
    /5R70V6mITuqdvr4enMJumpVp887ljNKXqXj4ths6b2uovDrTS2bfb0Ja9lk3w0B
    DVQnuJHpatL/mFiJZAXtbcFY54uP6OT+z5+JdMbQEYY67XbttWiG9+hN2l3KyOAr
    Xq7TlDVXqhNE2Y/QoQC5spVbnbuWHhXhhgkSs7oAecLzblF1WAlLW9zkffScyeOs
    11gqC9SaLzmZCab1T39q+VArnq9oIxlTrlBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:from:message-id:date
    :mime-version:in-reply-to:content-transfer-encoding:content-type
    :references:sender:list-id; s=fm2; t=1526629690; bh=KLUemqXEdVJw
    gPtNP0nzCMSQ/vEfbNfD+BpHvWMRvAg=; b=R16ov8Rf5+o8ZzWDn4Px8uexQLfY
    ZOMSDvO5v/8KOqAPTeDCikoS4M+YScc+z2Ip4VbCh5TDaQtCDUWes7AAdNeHDuAc
    68+VclE5VksdNnxHu8rHDVEc7/dUOowG7rRjNBP1pu/S71HDdEUfAtUsOP9X/wDH
    z7uuqZBL1/uegmAg60si8wiEFODGrnNqU3d1dxhcgqaoBBsAQIjQP/xgYFgz646A
    PsMljXA1G4Fn8B8Jmu3aMzg6cyKfB3A+906TWjU+TvnAx9iR48yaMq+c0/tnTwzE
    FK4kUJuV26q+555bTHHU8gmZDHCLa6RHzBbyaYYf+DuaZ2VaPwg+aXF8Zw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=samsung.com header.i=@samsung.com header.b=pYNZJ4n3
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=samsung.com header.i=@samsung.com header.b=pYNZJ4n3
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEYX5nF420l8SUf8QpoYhpU1VJrL+UeKa04gW4EiqZQVd4p/u5KNoevAXWODUDh7jfc+jzrROHJDGp0Qxu4voMy5bjY0nl/RokErNimRCmpNr0sGpgR5
    JJoEmI8KIk1jqWl9zwLZww4m6HmehhL6tit36n885KVyqjpEoJ+MQS5swiSjKk2G39o20kKYtkdY+m57drYZNc59P3gmrDB7ab+1fWzGrSXBg0MB8MrbOMRG
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=hD80L64hAAAA:8 a=VwQbUJbxAAAA:8 a=6ygFvtpv5MHGDUOUeb8A:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751281AbeERHr6 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 03:47:58 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58456 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751112AbeERHr4 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 18 May 2018 03:47:56 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180518074753euoutp02ddc29478e595174fc925f325d307130f~vrZmMx4Vs3105231052euoutp02b
X-AuditID: cbfec7f4-713ff700000043e4-ce-5afe85277bcc
Subject: Re: [RFC PATCH linux-next] USB: dwc3: dwc3_get_extcon() can be
 static
To: Roger Quadros <rogerq@ti.com>,
        kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, Felipe Balbi <felipe.balbi@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <8c0c7001-550f-7b4d-33fd-47b3812d5c14@samsung.com>
Date: Fri, 18 May 2018 09:47:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <50b8c19d-563d-660c-9cf1-134c64062ba8@ti.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djP87oarf+iDNbvZbWYfzPJ4v3z9cwW
        zYvXs1kcuz6R2eLyrjlsFouWtTJb9DzScmD3uL+X3WPxnpdMHvNOBnrsn7uG3eP4je1MHp83
        yQWwRXHZpKTmZJalFunbJXBldJ79zlZwkrtiXs9E1gbGzZxdjJwcEgImEk9P3GPtYuTiEBJY
        wSixafd6ZgjnC6PEyqPn2SGcz4wS87pnscO0nL6/jQ0isZxR4vyT24wQzltGiRV3nrOAVAkL
        BEjMnPMSyObgEBHwl/i6whCkhllgA6PE29tHwCaxCWhK/N18kw3E5hWwk2h5vZoRpJ5FQFWi
        e6YPSFhUIEKi6flPdogSQYmTM5+AjecUsJLom/gFrJVZQF6ieetsZghbXOLWk/lMILskBLax
        Sxx5tgfqaheJ542tzBC2sMSr41ug4jISpyf3sEDY1RI3XzSxQDR3MErc/93OBpGwljh8/CIr
        yHHMQEev36UPEbaVWNo0FexmCQE+iRtvBSFu4JOYtG06M0SYV6KjTQiiWlHi/tmtUBeISyy9
        8JVtAqPyLCSfzULyzSwk38xC2LuAkWUVo3hqaXFuemqxUV5quV5xYm5xaV66XnJ+7iZGYBI6
        /e/4lx2Mu/4kHWIU4GBU4uF9MfFvlBBrYllxZe4hRgkOZiURXivTf1FCvCmJlVWpRfnxRaU5
        qcWHGKU5WJTEeeM06qKEBNITS1KzU1MLUotgskwcnFINjDstZNerVqUusp/Xo7am+6v9pa/t
        h5fY88ek6L5e/P3wjSMHrwh1qrivVQq4+2le6KMbZ+fESiyM+FaV9HfDuvNhPuel57vsNuya
        PC/uW9q3mAmcOVzGukobr8wRUtcy3jbnQmph00uDphTjoAiG7HpnlVytTCFznUP7X04sq09W
        cHKcutVvshJLcUaioRZzUXEiAKI4WM4+AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t/xu7rqrf+iDL5+YLOYfzPJ4v3z9cwW
        zYvXs1kcuz6R2eLyrjlsFouWtTJb9DzScmD3uL+X3WPxnpdMHvNOBnrsn7uG3eP4je1MHp83
        yQWwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehl
        dJ79zlZwkrtiXs9E1gbGzZxdjJwcEgImEqfvb2PrYuTiEBJYyiixbNJPZoiEuMTu+W+hbGGJ
        P9e62EBsIYHXjBKT2v1BbGEBP4lv2/awgNgiAr4STWe3sIMMYhbYwChx6fwTVoip05kkPm98
        CDaJTUBT4u/mm2CTeAXsJFper2bsYuTgYBFQleie6QMSFhWIkLh3/hNUiaDEyZlPwBZwClhJ
        9E38AhZnFlCX+DPvEjOELS/RvHU2lC0ucevJfKYJjEKzkLTPQtIyC0nLLCQtCxhZVjGKpJYW
        56bnFhvqFSfmFpfmpesl5+duYgTG3bZjPzfvYLy0MfgQowAHoxIP74uJf6OEWBPLiitzDzFK
        cDArifBamf6LEuJNSaysSi3Kjy8qzUktPsRoCvTbRGYp0eR8YErIK4k3NDU0t7A0NDc2Nzaz
        UBLnPW9QGSUkkJ5YkpqdmlqQWgTTx8TBKdXAqPeehfPX3IyXfbLR7gcz1Vm3RrTPfxSUz7w2
        qSQuostlwcT7zg63Q6TzHl3SmCV/Ysu8egHFEBG3tw803V8qPpt8mVfxeMPkhNojbqWqsafv
        buTak73gR2mrRVV8VKGEsc/X9ksx9wL7thmsk037ZtBUEbDgxYvdvR+/5Yn2fb+95q7Q7+cN
        SizFGYmGWsxFxYkAv5j2NdECAAA=
X-CMS-MailID: 20180518074751eucas1p1990a9b3be738b63eb930c3f3987e61cf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180518074751eucas1p1990a9b3be738b63eb930c3f3987e61cf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180517160655epcas3p2b8e0c7aa08f2138882a84b5e2b7b291a
X-RootMTR: 20180517160655epcas3p2b8e0c7aa08f2138882a84b5e2b7b291a
References: <201805180059.3X1bJsDZ%fengguang.wu@intel.com>
        <CGME20180517160655epcas3p2b8e0c7aa08f2138882a84b5e2b7b291a@epcas3p2.samsung.com>
        <20180517160641.GA55289@lkp-ib03>
        <8b363802-50f5-1da0-0879-fe8d38231f5e@samsung.com>
        <50b8c19d-563d-660c-9cf1-134c64062ba8@ti.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 18.05.2018 09:38, Roger Quadros wrote:
> On 18/05/18 08:39, Andrzej Hajda wrote:
>> On 17.05.2018 18:06, kbuild test robot wrote:
>>> Fixes: 5f0b74e54890 ("USB: dwc3: get extcon device by OF graph bindings")
>>> Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
>> It should be static of course, my bad.
>>
>> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> I don't think we accept patches from robots, yet :)

What do you mean by 'we'? In case of whole kernel it is not true:

$ git log --author='kbuild test robot <fengguang.wu@intel.com>'
--oneline | wc -l
183

Regards
Andrzej

>
>>  --
>> Regards
>> Andrzej
>>
>>> ---
>>>  drd.c |    2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
>>> index 2706824..218371f 100644
>>> --- a/drivers/usb/dwc3/drd.c
>>> +++ b/drivers/usb/dwc3/drd.c
>>> @@ -440,7 +440,7 @@ static int dwc3_drd_notifier(struct notifier_block *nb,
>>>  	return NOTIFY_DONE;
>>>  }
>>>  
>>> -struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
>>> +static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
>>>  {
>>>  	struct device *dev = dwc->dev;
>>>  	struct device_node *np_phy, *np_conn;
>>>
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

