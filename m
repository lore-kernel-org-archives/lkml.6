Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE06C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39EA22150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="X069eNJj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39EA22150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731908AbeISWWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:22:38 -0400
Received: from mail-eopbgr30060.outbound.protection.outlook.com ([40.107.3.60]:61480
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726911AbeISWWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:22:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nO1Jm3r2FuNYSPDM0dW+LN3CAysuCM9Nw2RS3E28cto=;
 b=X069eNJju1+KEAIVsouGQ4w5DdaC3cNEBqS/1vPYKKiaLRzu1tIl3Z/YONw4cVb5l308Xj0hLsvb07AGYkNqutjDhuaSbauQi9Z78k57IK6onsBiBRXWtyCtpHWbgBUUHRQNJL/F/w/xgfzVPacroT1XXS3MVPMyAfDYt+7IhSo=
Received: from localhost (217.140.106.53) by
 HE1PR0802MB2554.eurprd08.prod.outlook.com (2603:10a6:3:e1::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Wed, 19 Sep 2018 16:43:49 +0000
Date:   Wed, 19 Sep 2018 17:43:47 +0100
From:   Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Sean Paul <sean@poorly.run>, nd@arm.com
Subject: Re: [PATCH 1/2] drm/atomic: Initialise planes with opaque alpha
 values
Message-ID: <20180919164347.GA21403@e114479-lin.cambridge.arm.com>
References: <20180919155700.10342-1-kieran.bingham+renesas@ideasonboard.com>
 <20180919155700.10342-2-kieran.bingham+renesas@ideasonboard.com>
 <20180919161545.GH5565@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180919161545.GH5565@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [217.140.106.53]
X-ClientProxiedBy: AM5P190CA0007.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::20) To HE1PR0802MB2554.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51bd4f05-0a20-4731-5c31-08d61e4f1377
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0802MB2554;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0802MB2554;3:kMJF5RqQx+1HL0MerDkpwzdJc63BiHkSQSioc5t4S+MYvfqwvgkJPywc6XSjlg5DNYCFuT7R/sUYdCt0OViiXZxA04TZjNX+mCi5KhalTrNMCyfNJfzcT/m3FSuWq/xOLxel7oDgryX2Ij/Fu+SDvy9hPUW/MuIPu9RFjqRCtSVFwHceRk3Nia7F/HbDlYJ1xRvTAZsWFLgppGdzIZLa1pWAxDY9WsedSDZ0DEDMMLxf//qme/LZByC+y/MdIBbS;25:Gb3ugUkV28aAHTSBXnzmV9cRQWBmStGJsmfiu6TRUCDu6I0YiyAU4yBzIEtps0yVm3i5bZA+QTOnF5/zMeE517bIDZyw6Bch0IvVGJM2TUiz1EjDmmBSWBo2zCx5a90r5Kb+6z//3RE+oYHvDpsLnrptZNm7VrOWw7H4w3ROQNDEEEmbd2iZxx3P8N+M/9HfinM1AB/Ub0D78PvC7341u2/KXcPs7mfv2HZm1mXxp4GymmPgQlmc2+9loM9BrhV7+uqlChCeDBiz9VfQ/UfA43I4BOz3ZiuR2JyGm8CSA9/M6+vVOidlMIpKJljRFObAaf5/RF6MjOz86AW8PRDszg==;31:VVH9KEPQWaodxHuzTsAAAaEY3W6MBCVZ86nMSAmkdeLuN1IVvbO9SWcrAjcV3wRCnOfnMns9hd49PEYehRR3t7mrSWvJ2WmvTXnJoPrDOo9beQzTkW0veeuNJk9LscPSPtwNga0NWP+yl1JKhWlOgE4eNAAULmj0DlxtpUz9GjQearIAagEfo6Md6Q/zZwCML9AUYXkMUtO7Kq75NYwBUakUU3tS2zbGZ/ZHI4UX/o4=
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2554:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0802MB2554;20:IrLOL46Ds7zWW7NsWEks7L/Xq51/hW71tNhIj7nzsP+0a7dTqDXIWSLW+19eHZ0/vYOwGb28MqIl3k/obc9O1auxf2RFPQy0X1N7eoLE4Zu162Bbjkuaa3lFxBAOhtbkwRBJabtWuY1UlsK3aY7rN8Mjw1ef4wMbNn6j/SvMZxdH8su/O1tcWpCfJuX3i3PnuMadNihSek3wqHSFb8AqAJkjBGul3bqTFJnMqHskozzX1MnyRJwFaIc1rJiseCA1BDZOHKigNPxxrJIKVuywHwz96sJvDP5pWld96AhfkrwNC4QkJLIw4lxOnC/6KyS3iOGx8VqTfsF/as2aHV5kLys3Nlr4ZUSEPchSX5Edi8iij2NVjL8Zj71nOjkiWT2fQ9t2vjJSKW1CVY0Bgzb44qXvEUIDJcCooL0cYwMTGDo=;4:bhlUINyYE8sWSonzdkRgmMmWJOvZbOXEltec6DCMezBBlVeZUr/l5jR4C3Mx4e3NqqCpI5nI6yrmZIJsKIwfGhAU2wnBzUtVoq0OmRQsk0bJzCEdzEIbJd6NRCHwxwA4jv735AMdLvSC1l6Cmeoc1I6qDjbe7fko1+Ux9YkFcwVAzFJxdDH6QGTiFUji5szocyRzzgXf0TqeUtt8jpS4aMOLAzIw2x9vAIfrniXHxuUA1PVlWLQh1CSXLUKik5ZGS073RmibwPIZj7yntwp+hgJStLxPKbdaKS92hPz5cdKRFEkAM9J2roZMxoE2HfT56fdpi4fM+ookHo7I2lcs9AK61DcSYu65hkWgVtMDuq+ws+xR2SVQpGkOMUx7DZ55
X-Microsoft-Antispam-PRVS: <HE1PR0802MB255410603E65922A561C329DBC1C0@HE1PR0802MB2554.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(217544274631240)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:HE1PR0802MB2554;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0802MB2554;
X-Forefront-PRVS: 0800C0C167
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(136003)(39860400002)(346002)(366004)(376002)(396003)(199004)(189003)(54094003)(4326008)(2870700001)(76176011)(966005)(81156014)(58126008)(316002)(54906003)(72206003)(1076002)(47776003)(478600001)(33656002)(97736004)(14444005)(53936002)(81166006)(8676002)(66066001)(6306002)(8936002)(6246003)(186003)(23756003)(26005)(16526019)(6346003)(229853002)(68736007)(86362001)(7736002)(476003)(25786009)(6916009)(486006)(52116002)(446003)(305945005)(106356001)(6496006)(76506005)(2906002)(3846002)(956004)(11346002)(6486002)(5660300001)(386003)(50466002)(105586002)(6116002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0802MB2554;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alexandru-Cosmin.Gheorghe@arm.com; 
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;HE1PR0802MB2554;23:zbS1MptkXCGi8RercW6YaP44HyFwsohYdIVyd?=
 =?iso-8859-1?Q?UZYdkUaa0Jc4yfK2YGv20v6orp5OmtuP5JGNLf95zG6V5RXIIP27dqHHrl?=
 =?iso-8859-1?Q?vnao6oewvSXpiIb5rx2NA0yC6SVUixdHSZwCYdFwb7bp+NMZTA+iZATHDT?=
 =?iso-8859-1?Q?ccSVQIHRXDaCst4lHWTl3tctFXZzD2mqil5g8TfjDta5514IU1T6I3VhIn?=
 =?iso-8859-1?Q?tQGxIUNNLo+Ji/Tyw1IqtKfbxr8YU+EY/LwO/MOUXpBEGP/Mhl4u1LV/W4?=
 =?iso-8859-1?Q?hNo9vby7+kWLGUPzeV4pO4voPIHgaBTjbhtxjlzf/1bHZsJi4UZYHDlRkD?=
 =?iso-8859-1?Q?ud2V+Jod8L6J8Jn4H87BXStWuLhJG6z1Uw6vJzm9KoMsN2U4xhicytM/AR?=
 =?iso-8859-1?Q?a0Ola7PPqvgOsvxRh9sZq5bmkT+RK61nrU6UEhjNAdcSmg4t5nwQdidiep?=
 =?iso-8859-1?Q?aJ4lqPKq6KusVlTlv0pn1rR/mxxlGxO2rmtynYewUxieYmYbAR+W25K5R8?=
 =?iso-8859-1?Q?UeQEirNY3tRcZV/jW1Ml74a4T22xTLBRsQOA2Czn6/HKc4FGXnEHLRWiqk?=
 =?iso-8859-1?Q?KP4cJG64ZmPAdExG4nUqN+kt2p8JIRXjc3w8K1xPDoJToYO7bz958qJG27?=
 =?iso-8859-1?Q?IhsFDcmtShDhMbmkg2upXWWrXAWru1aF/NOjZclGS5Tr6L0gZvH/TFILR2?=
 =?iso-8859-1?Q?4r3/kCnYxaAP82W2eY4ZwxJkVv/Re6+zI/pPWrju6WI4OZZG/fOMhISOdF?=
 =?iso-8859-1?Q?XqkqMEGWCym9sh4RovA1Ol6csiLO6NMvHMY413t7d0KjA5TG/THtmBmQg5?=
 =?iso-8859-1?Q?PZE0NRi59cUgrndBLEvaezQYTHcRuYVvI26xLKYXvlkwH1ZMNXn/iwoadH?=
 =?iso-8859-1?Q?yinjf3t36FZO1ZN7wMUl06PgtxApO5qGNd9FJvPZ76D9n+/XYCIwoLr5Jf?=
 =?iso-8859-1?Q?rXC5mNLsEmc4oMEMBSs7X5CTaBQnwxilOPOTGziP2KBcevsep8pB2Baz1v?=
 =?iso-8859-1?Q?ZrfdC6tvauKK/xJFP4yM/3UEQuHnocAOmHcChyQ0WvX1ou3t+zp9dLcuX4?=
 =?iso-8859-1?Q?hF52si29wmgTN4SRYszn2GudlDJJscWejh5lJfIVc1otH+wjHcRMp30p1f?=
 =?iso-8859-1?Q?U3MlrZ7NogyTTQy2U1TkCBr+ST612NeCOeQz+Rvuj5sxBZyw0QEvDZtNkw?=
 =?iso-8859-1?Q?R+SMqr+b9a6T8hlU48hJAFS+Au2DhBs9LivVHynXzfnG8ThcIF0QDtfE7A?=
 =?iso-8859-1?Q?ff6NfuBbAj93V7u+mKO4haU1cspg7fxNd9N/XMPfr3TOYEd4YIHJGJ5v5/?=
 =?iso-8859-1?Q?V4mrryEguwf4I7HCCBm+n9vh2ZSsf+sqM2FYHKA/CIvcrIQF9LyRPoH2kg?=
 =?iso-8859-1?Q?gzqhejCyNS8KV85gcRZ49niDZImvrLZTMAM8mss12a8JLGk08TBEA=3D?=
 =?iso-8859-1?Q?=3D?=
X-Microsoft-Antispam-Message-Info: SxoT9iyHo4fY7B3a1mKPsXpT6pRzgOzt3xEHwCOgXuqHbq7BLc0HvoDLMVPi016ZBtEsU7mTwihzr0ILYFvsFsAVKmd1dl50GeaHXevouqtbKEzoD23Nx0beI+BYn/VA6/xCxpi7obmXme91wWO9tnMKb4b7UQoB7VmIWHlxQEhn08D39ypJaOE4UaC3MhC9iSnSRLwP3l7cmODqwkXF44Le6srHGWnWdI1AoRq05ioZ8X6yXiK8L40ZS6EFm1khOfZZ5au0ouy1rMJcZABCcWX1QdRiQGaxY9kb00oPajd63ux4xzjQ6bPOeXzaG7DQEQas1uHYqQdqTe4ICYCsZeCz1/YIu2Un7baXdBYrQ5Q=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0802MB2554;6:b6ydHDGLBycbiRKuHmOp//1Nbcu7jcs2BrbmKkRFriuVKjwT/DZnra8iMGp61LaKFayb5PqWsulHIlD9pgr8RZW9KgOSTBcQ3w6ziwzP/iYzWO1KPsQyyln7b8Ls7TO51iApRSC43Q2FxJEHlrFiRHft7erVAKk9UNmZakXz8IyXoRrQnIjWwFSkWMaOiah+uh6Zmtht57jMLg9PmNany5i7JrZgqlJ3Ps/87ut3/h10guvxirdhW4FD9aYNMQU36l2gM+B+YJpWrgnAJtjwBx5sKBGM5TY8CJc+IyE00Q1IqWbYAK5eRN38dmkZ6eMBwLHBXCGv5RUjm3A3JkkKBs7LQbp2RUTEnDDBc5aPPgdwtBJ6qcL24M9Q03SfjBsbFniwFDq9d8/IuRLNdrhfVeb/cIc/wNoBtpDG+7GJmUheDoUnVCS3RkjlYLnkgr9dGh9aj7cWTFU9XDxxJpXblg==;5:1rrdOQgIQSVoGLuTf3fnqRY+Si3W4SU4zgOj89xMx4JHRHnflulkS7tDZv7SW0Cn8+LZP4wLEqXjDF5wSY7uA6PKCFwouplu/YUZOhJ6vLumKg6hC4/6aZZjLuL0CcNrsqaz27AUL2+4M3lOCsuJihY5NrHRybg2Tc99yIeuQAw=;7:oVUF/fVuQFXS+q5Oc7px/sP7UjULgmlgMUI8nQSR9IVrZ/hNyAMasoJuyvp35jDKTObddTXnfuaRp3E8FPX4c1vY+U/vbz/qJEkRze1kXJMm0PA6p6hjVTC5NXxG+guyOCf3089rGE+vOWcFm3EuWqAmCPx0nO6f0fPFD7RxFNz7EnAw/zLopWXF4V+DD0pV2FonZlPoFecjg1g9SB3esoz1HtN6HqxVHu5XFLQSnlRX+bQOKh1PXqbXKKjksfsN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2018 16:43:49.5936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51bd4f05-0a20-4731-5c31-08d61e4f1377
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2554
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,


On Wed, Sep 19, 2018 at 07:15:45PM +0300, Ville Syrjälä wrote:
> On Wed, Sep 19, 2018 at 04:56:58PM +0100, Kieran Bingham wrote:
> > Planes without an alpha property, using __drm_atomic_helper_plane_reset
> > will have their plane state alpha initialised as zero, which represents
> > a transparent alpha.
> > 
> > If this value is then used for the plane, it may not be visible by
> > default, and thus doesn't represent a good initialisation state.
> > 
> > Update the default state->alpha value to DRM_BLEND_ALPHA_OPAQUE
> > unconditionally when the plane is reset.
> > 
> > Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> > ---
> >  drivers/gpu/drm/drm_atomic_helper.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> > index 3cf1aa132778..e49b22381048 100644
> > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > @@ -3569,9 +3569,7 @@ void __drm_atomic_helper_plane_reset(struct drm_plane *plane,
> >  	state->plane = plane;
> >  	state->rotation = DRM_MODE_ROTATE_0;
> >  
> > -	/* Reset the alpha value to fully opaque if it matters */
> > -	if (plane->alpha_property)
> > -		state->alpha = plane->alpha_property->values[1];
> > +	state->alpha = DRM_BLEND_ALPHA_OPAQUE;
> 
> I can't come up with a solid excuse for not initializing it always.
> 
> Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

Neither do I, so:
Reviewed-by: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>

And thanks again.

I plan to push it tomorrow to drm-misc-next.

Now, I've seen the plane_reset patches in the pull request for drm-next
4.20, I wonder if someone could tell me what should I do to get this
patch on that train.

> 
> >  	state->pixel_blend_mode = DRM_MODE_BLEND_PREMULTI;
> >  
> >  	plane->state = state;
> > -- 
> > 2.17.1
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> -- 
> Ville Syrjälä
> Intel

-- 
Cheers,
Alex G
