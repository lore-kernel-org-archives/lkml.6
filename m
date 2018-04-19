Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeDSKj1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 06:39:27 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33634 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751042AbeDSKj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 06:39:26 -0400
From: Philippe CORNU <philippe.cornu@st.com>
To: Yannick FERTRE <yannick.fertre@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Alexandre TORGUE <alexandre.torgue@st.com>
Subject: Re: [PATCH] drm/stm: ltdc: fix warning in ltdc_crtc_update_clut()
Thread-Topic: [PATCH] drm/stm: ltdc: fix warning in ltdc_crtc_update_clut()
Thread-Index: AQHT0NNJNWz7J5w5Gk+8HKZUkR0J66QDBKwAgATNdoA=
Date: Thu, 19 Apr 2018 10:39:13 +0000
Message-ID: <5c8512f0-1eb7-e517-12e2-ce70c91c7112@st.com>
References: <20180410135312.3553-1-philippe.cornu@st.com>
 <f5b79561-0084-96f9-6986-0f17c11f0143@st.com>
In-Reply-To: <f5b79561-0084-96f9-6986-0f17c11f0143@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.120]
Content-Type: text/plain; charset="utf-8"
Content-ID: <69885DE980C3D547A372C84F0A4DA9FA@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3JAdWgr021072

Applied on drm-misc-next.
Many thanks,
Philippe :-)

On 04/16/2018 11:18 AM, Yannick FERTRE wrote:
> Reviewed-by: yannick fertre <yannick.fertre@st.com>
> 
> 
> On 04/10/2018 03:53 PM, Philippe Cornu wrote:
>> Fix the warning
>> "warn: variable dereferenced before check 'crtc' (see line 390)"
>> by removing unnecessary checks as ltdc_crtc_update_clut() is
>> only called from ltdc_crtc_atomic_flush() where crtc and
>> crtc->state are not NULL.
>>
>> Many thanks to Dan Carpenter for the bug report
>> https://lists.freedesktop.org/archives/dri-devel/2018-February/166918.html
>>
>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> ---
>>    drivers/gpu/drm/stm/ltdc.c | 3 ---
>>    1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
>> index 061d2b6e5157..e3121d9e4230 100644
>> --- a/drivers/gpu/drm/stm/ltdc.c
>> +++ b/drivers/gpu/drm/stm/ltdc.c
>> @@ -392,9 +392,6 @@ static void ltdc_crtc_update_clut(struct drm_crtc *crtc)
>>    	u32 val;
>>    	int i;
>>    
>> -	if (!crtc || !crtc->state)
>> -		return;
>> -
>>    	if (!crtc->state->color_mgmt_changed || !crtc->state->gamma_lut)
>>    		return;
>>    
