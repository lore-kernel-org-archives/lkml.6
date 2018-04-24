Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756113AbeDXG6y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 02:58:54 -0400
Received: from mail-ve1eur01on0098.outbound.protection.outlook.com ([104.47.1.98]:23134
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755907AbeDXG6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 02:58:51 -0400
Subject: Re: [PATCH v4 7/8] drm/i2c: tda998x: register as a drm bridge
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180423072301.11962-1-peda@axentia.se>
 <20180423072301.11962-8-peda@axentia.se>
 <20180423160833.GF16141@n2100.armlinux.org.uk>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <5d6866d0-75bc-4de8-9b87-4fee5430e9dd@axentia.se>
Date: Tue, 24 Apr 2018 08:58:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423160833.GF16141@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0701CA0048.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::16) To DB6PR0202MB2776.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;3:0Y2bVpwhQYW6TTCfCSsYwGPmvPMkpeSCAgIYQuWekD7AZ07WA2GeiWROZCtsRVn5/02AKRo55BH1wINS3H//MYy0gQHTcobCOV1PYQlY+2Vl5RU5G9Mw4MolU21a0/X303lLG4Ig4tqMLN74SvVXsZcY8/EeoJQRXoyfTE5g5C6/QvTwvZdCY8BrfOH9sHA9rnenrGowHpp8EQXnWxUZtkdUXiLpjwLy4iSPaC1dvs9lipewzg9cA6sI9Eowa6nf;25:WQOWZ9e6sLZHumOqnqTJe/oyZcKjfYeZR5yZq+QrItdlKu5qKDAbfeiBhoVjWO/yEHLgpVOzZxRnLBOv4nwWrRnL83hTwRkQruambE6PxabnFbxKeDm4SUtkXIkG8ja0qScHvIGLbuvJAjf5vA+8Lt4PRcu0dEhYt11iyQMznqTjGU8qUjJgmQbDx1+ATpAqLEu0mFzkAcr3VZaEzLb5/mdOWUu9JsG6PPGX7pPxKTGpcdV0bVonkLVE4zG6VS3cs6eWPByNbp0s0ENftrpj8Tu+85AujtQvpU/r8RwfHJSHrhgWZOAgzYMhhJcVPil9J2DhTk1OdPdFvNY50o04Kw==;31:kRDubwmbTs+xc5np9opK1KY+qmVZc13rRbsro4SVerjzmX7ZvVl8OL7wT+rjUP0opl7j9FJrMhFqjSfYNKHkw0htFeb4lrawGqPghK9dRFuo+OUG6ywYvXBeWeig1ifAkCuy3j+2EN4r5IIAeizFM7a/6sIFRESmdGCpVCjPRGyzuItO5hL+GsAoYPKEBiDsz8YFMQjAEcgDv9liPW7iPNHJcGioegygDrJJLr+icAA=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2776:
Authentication-Results: outbound.protection.outlook.com; spf=skipped
 (originating message); dkim=none (message not signed) header.d=none;
 dmarc=none action=none header.from=axentia.se;
X-Microsoft-Antispam-PRVS: <DB6PR0202MB27764D44B36A2E3C508D8AD3BC880@DB6PR0202MB2776.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231232)(944501410)(52105095)(6041310)(20161123562045)(20161123560045)(20161123564045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:DB6PR0202MB2776;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;4:RqrKeyF/9zCSHhqwyFgwMsbM3CoDXIzyiWkERgxjgeJbJ2+Jl6IDdjhfnqE1K74L3pckJf3sKcpomXdT3g+zr1g+cbbDDrtwh4ulHBj1WDwA7qZmrt2w7kdaYZ7FmWdN/ECr+lTg/7R7mswgZLd//l4B8rrcN2Gp4K1YUapYIhi8Wda2Pu51Hsa74h5WJQWGm+cNI+83B29qshm44x8jXvkYoPZjb0saMYvO/7lVBKw5Xin4Hy3WR0ztTXNR5vjE0fm6ZBFGZ9/Q3aVuvPnUsg==
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(376002)(366004)(377424004)(31686004)(31696002)(3846002)(7416002)(65826007)(5660300001)(575784001)(305945005)(7736002)(86362001)(2616005)(53936002)(4326008)(6246003)(476003)(11346002)(956004)(446003)(6116002)(6666003)(16526019)(186003)(77096007)(6916009)(8676002)(6486002)(81166006)(229853002)(8936002)(54906003)(16576012)(316002)(66066001)(47776003)(2906002)(50466002)(230700001)(36756003)(25786009)(3260700006)(117156002)(478600001)(74482002)(5890100001)(386003)(52146003)(2486003)(23676004)(52116002)(26005)(53546011)(76176011)(59450400001)(36916002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2776;H:[192.168.13.3];FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzY7MjM6WFU3SEFkcUJJTUxwZmN6ZjVSeFFyZmFX?=
 =?utf-8?B?WXhuZmM5bnhHYmN3SHdhVEpUMldDQ3lZVmE0QlVraWpHRGt3SytGNXlXdWpK?=
 =?utf-8?B?U0tUVHoybFkySEZGUUgvME9PNGFBcXhuWnN1SlhWY0JIaWhaNGRhanV3Ungx?=
 =?utf-8?B?Zng0RVJKaFhBS1RUdS9vSVdXblhWTzFkT25UTUdUMWRQY204aU9QbHZxNmJI?=
 =?utf-8?B?b2RkQWc4WGpyT2ZPSnl0ektBbUNyM29lbUpuRXF5dGxUVUxGZUM0blN3Z3Fl?=
 =?utf-8?B?c2ttV3pYOS9tbnArZ3pQOW1OZE51LzJtUFlIenlNNG5ad1BxcXE5YmQ2bW5P?=
 =?utf-8?B?V3dxV0dXckMrUWlEOUlyY0pteThxc0dXdDRrMWhZekRQZ1VXMi9FWTg5YWxz?=
 =?utf-8?B?TzZoMDBzeEFoQTkrb3ltTmxqYkhQSzZCUjF1VTJhS3BNUFg1MEVWakZBZkR6?=
 =?utf-8?B?eEcxMm5iTy9tNFI3NUw0K2srUExoY2p1RlVDR09ndGw5djhVY2pDRS9MYWN2?=
 =?utf-8?B?M2N0c1d4WkRnaEtsdzJabkRETlMrV2VpOXcwaUxKaWNBdDk2TndVYUdGVEJJ?=
 =?utf-8?B?YTJQYmM2L1J4NWNhQ0IybzJYOHYzWUU2eXEzS3RnZENCN3gxOFlYU2ljdy9Z?=
 =?utf-8?B?aGZiMWtLdTgrdjNWWTlwa1RmbkI1WUUxZXhLUituVncyOFBNNFBKOWJFS3Ew?=
 =?utf-8?B?emV6VzJKRHZSY0dmdUVXZzBNR0FtYlJDSGNsTW9nM0dtK0ZzRDlZK0xxZGNJ?=
 =?utf-8?B?ck9aalRNSjU5WHhsL3pYOHMzRU9YUGpuKzF6SkhGaHdZNEcva0VjeVdta1d0?=
 =?utf-8?B?azBIbGlXNXBKUVRmZktjS200SHRYMDdWK0MvSzVkM1VHdXRuTUhzS2JXWTFG?=
 =?utf-8?B?bEh4SXRQZnhheWJNZE1POFRvREdoaGxwQ3l2QW1JVUlESkhmcUZkdGhLTkZp?=
 =?utf-8?B?bmtuRWtOR0hVWXZvMUFwOUJkbGZlVE1aTjg1bXVQdGtiM21XQ0JYeC9uaDRJ?=
 =?utf-8?B?aEIydWROY2ZDQ0pBVGVOeVh5ZTNySzZvcklRSEc2QW1GcGtzbEljd05TSjMw?=
 =?utf-8?B?bnVPc1JZbkhyY045ejRwY28zTzhDNysvTlljSlBQK0g5TXBhckRscldtOGEx?=
 =?utf-8?B?bSswb3VNYkxtZzZxOGwvYUhXeDVWQ0hyTHF5WmE2YWp1VFg5dk5qTlRJVDRI?=
 =?utf-8?B?ZTJ4RGlNcmN5Yk56NllhTHA2MjRqbmdTN0lqcHNid3hIV1RRTU5xTWkrd1Mr?=
 =?utf-8?B?ZWV4TlNtTFhTMmdNNUI4TDI4eUdhZUxmVDZ2ejA2RlI4WG1sNE53NmpjV0RB?=
 =?utf-8?B?RlU5blRXR3g2ZVd5dEkxQWpxdXVINk9udTVVc0xFaWlPMlpGYkp6YU1uRkF4?=
 =?utf-8?B?VGxuMmxyVTdZd3o2VmhEWHdQcC84M1BJcEVxRWlQN0t5K2hXUG5UR2lVdWgw?=
 =?utf-8?B?aDNnN21ER1hXdmh0ZndhS0dQMFFGYm5wdWVITk5VTnZpV0REL09neFVjc204?=
 =?utf-8?B?UXdGOEZzYjZhaFBOM1k3am5uZXp3amVDZ0Z6dDNUQlNVNHdIRW4wWkZDQTVX?=
 =?utf-8?B?Umd5YUFlKzdVMXpTOHZhVGFLaUwzeXBwRndpa01jQmpqZDVYUG93VUFOMHVU?=
 =?utf-8?B?Q0V5UGZGbWYzcTd2dTB3T2pQUWpGUUxIYnJ6bU9WbGlmRjJ0TXpSQUlCdzRL?=
 =?utf-8?B?QWgxUHphRVNvRFRpcHQ4eXpFLzNFM0JpRno2eisyczFzUXdHNnh2OWZaeFd0?=
 =?utf-8?B?dVQ3ZmVraDhBMnZYREgvYk9hc24wYmoxMi9nREIwaDNYSnNkek9PS2t2ekg5?=
 =?utf-8?B?dUhXblUwWExROVoxTWF3Ylk1NlJueW11aUJaVzcyZVdRa25jeXlIbFRSemZS?=
 =?utf-8?Q?sRLDpLEoU7opg=3D?=
X-Microsoft-Antispam-Message-Info: 1+z7Pm/yxv7KSUE7c3or2/FQSKwWuYcdUW+seynTNp/9WIa+5EvNLveoQdTJXSYnIFziOWcs4nOP9iPOTx9rzY6ko2HVD5wfohI9J1TpnMnN0Gbn6XLRsqVGlCxQVB3yS8RNAbl/Te3uUWy7kyGI9q34yIilyogA74EuNEGv2lXRedHhCJSPyq1awtRx7yme
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;6:18osNC792jUeHePexQkWvJXsVCJRLtWOtvy2rJxO/f3YzdhPetkfjHPUJ9TMhTnakKuU/UMoCGsrfqvTLHMVXvi6/BP+f6hsRXcvTabZGKiKTd0AtAcivSGdctzfvaYAlzq6GSHp+B9Rco9TrLsnehtii5PPr/EeCA4cxuDrJ+KO6VTPU52H49klLWvcG1usEoBVFtkgw82cI6tGPsSycvj1JOhPVhLjc0AGUkFdOG0GnkegzKgeZuRxWNVGUcEOztR/LkPSiqW+7otkkQMkOjlbR+7Za6niee7AZJo2uRNnK40lBhNISAPKeVkpcjJ6DhsSna3yCcsTuPPBH5+heN6B8dhZcxwKT0BvYRuRgoORm8RIUUoe5nnkDJuM1kM2eO6JcyuaoA2NXOhEUL2MXs3wRWAOhtcJeFVgg0MhHw/Bud1/tz5d+ZZmE3vKAIg1mWztrRAjKNQ30WOhA7V4Ew==;5:0mgUpoQ6e1m3vkSXWpD5lkiMJz4HPlOGMl8JknO58O5RRA1JjDZj+TQBdNprXrsTtz+5QEWiagt0xp2XAGQcVeq1N8T8PbbEeF8s7IbsedHZCmSTaLcM6rH6xWOqtCD1u+LEhH5DopfbEZWqOwNxhGN/ZhM6Q48Noe/6XBKo2dg=;24:eYqTnXHFimmNbA5qeBQS/klsfJN+2ja+6nGneglM5LQGl6sewq4c/xGfRXtr0J5wLBXnWrMdOo8al/L03bxpaxE5z5tPis7txJb6JuW+/qM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;7:A3mI89I8U4IbX4twiDkm/vhXKwqZUZnkSKD4rBisIXDPOISQFqzUsCc+Rxl/Nnc8tNPvC6ZbwWAFFdHi/w46kIYO52tBNTG+LEcDVmwQ6d5YyZMASnHxWOspcemSV9exhiQoRgrFjysI+i+hG0s634uOOnQyrFKznjueOdKTcIWBysGyj2eKkW2HC9QNgec4VAbnaA6d1Lk2KDbTWwEICfR2yOGaY1m7nG/O6rjwbMTwl2BAvx0XZU9PPyQXbGAh
X-MS-Office365-Filtering-Correlation-Id: 4fbf5b10-2a25-4ea9-28aa-08d5a9b0d3c3
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 06:58:46.3195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fbf5b10-2a25-4ea9-28aa-08d5a9b0d3c3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2776
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-23 18:08, Russell King - ARM Linux wrote:
> On Mon, Apr 23, 2018 at 09:23:00AM +0200, Peter Rosin wrote:
>>  static int tda998x_remove(struct i2c_client *client)
>>  {
>> -	component_del(&client->dev, &tda998x_ops);
>> +	struct device *dev = &client->dev;
>> +	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
>> +
>> +	drm_bridge_remove(&bridge->bridge);
>> +	component_del(dev, &tda998x_ops);
>> +
> 
> I'd like to ask a rather fundamental question about DRM bridge support,
> because I suspect that there's a major fsckup here.
> 
> The above is the function that deals with the TDA998x device being
> unbound from the driver.  With the component API, this results in the
> DRM device correctly being torn down, because one of the hardware
> devices has gone.
> 
> With DRM bridge, the bridge is merely removed from the list of
> bridges:
> 
> void drm_bridge_remove(struct drm_bridge *bridge)
> {
>         mutex_lock(&bridge_lock);
>         list_del_init(&bridge->list);
>         mutex_unlock(&bridge_lock);
> }
> EXPORT_SYMBOL(drm_bridge_remove);
> 
> and the memory backing the "struct tda998x_bridge" (which contains
> the struct drm_bridge) will be freed by the devm subsystem.
> 
> However, there is no notification into the rest of the DRM subsystem
> that the device has gone away.  Worse, the memory that is still in
> use by DRM has now been freed, so further use of the DRM device
> results in a use-after-free bug.
> 
> This is really not good, and to me looks like a fundamental problem
> with the DRM bridge code.  I see nothing in the DRM bridge code that
> deals with the lifetime of a "DRM bridge" or indeed the lifetime of
> the actual device itself.
> 
> So, from what I can see, there seems to be a fundamental lifetime
> issue with the design of the DRM bridge code.  This needs to be
> fixed.

Oh crap. A gigantic can of worms...

Would a patch (completely untested btw) along this line of thinking make
any difference whatsoever?

Yeah, I know, all other drm_bridges also need to fill in .owner, and
the .of_node member could probably be ditched from struct drm_device
etc, but this was just a quick sketch...

Cheers,
Peter

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 1638bfe9627c..3577e50cc6c0 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -138,6 +138,10 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 	else
 		encoder->bridge = bridge;
 
+	if (!device_link_add(encoder->dev->dev, bridge->owner,
+			     DL_FLAG_AUTOREMOVE))
+		return -EINVAL;
+
 	return 0;
 }
 EXPORT_SYMBOL(drm_bridge_attach);
diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index b8cb6237a38b..29eba4e9a39d 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1857,6 +1857,7 @@ tda998x_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	bridge->dev = dev;
 	dev_set_drvdata(dev, bridge);
 
+	bridge->bridge.owner = dev;
 	bridge->bridge.funcs = &tda998x_bridge_funcs;
 #ifdef CONFIG_OF
 	bridge->bridge.of_node = dev->of_node;
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 682d01ba920c..f0f8b2a85c28 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -224,6 +224,7 @@ struct drm_bridge_funcs {
 
 /**
  * struct drm_bridge - central DRM bridge control structure
+ * @owner: device that owns the bridge
  * @dev: DRM device this bridge belongs to
  * @encoder: encoder to which this bridge is connected
  * @next: the next bridge in the encoder chain
@@ -233,6 +234,7 @@ struct drm_bridge_funcs {
  * @driver_private: pointer to the bridge driver's internal context
  */
 struct drm_bridge {
+	struct device *owner;
 	struct drm_device *dev;
 	struct drm_encoder *encoder;
 	struct drm_bridge *next;
